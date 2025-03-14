//
//  NetworkModelTests.swift
//  KCDragonBallTests
//
//  Created by Luis Quintero on 6/3/25.
//

import XCTest
@testable import KCDragonBall

final class NetworkModelTests: XCTestCase {
    private var sut: NetworkModel!
    private var apiClient: APIClientMock!
    
    override func setUp() {
        super.setUp()
        apiClient = APIClientMock()
        sut = NetworkModel(client: apiClient)
        sut.token = "some-token"
    }
    
    func test_getHeroes_emptyHeroes_success() {
        // Given
        let successResult = Result<[Hero], APIClientError>.success([])
        apiClient.receivedHeroResult = successResult
        
        // When
        var receivedResult: Result<[Hero], APIClientError>?
        sut.getHeroes { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(successResult, receivedResult)
        XCTAssertEqual(
            apiClient.receivedRequest?.url,
            URL(string: "https://dragonball.keepcoding.education/api/heros/all")
        )
        let authorizationHeaderValue = apiClient.receivedRequest?.allHTTPHeaderFields?["Authorization"]
        XCTAssertEqual(authorizationHeaderValue, "Bearer some-token")
    }
    
    func test_login_expectedToken_succes() {
        // Given
        let user = "testUser"
        let password = "pass"
        let expectedTokenMock = "token"
        
        
        //Expected -  Aqui simulamos que la respuesta delm server es exitosa,
        // .succes y que el token que devuelve es el token que hicimos (expectedTokenMock)
        apiClient.receivedTokenResult = .success(expectedTokenMock)
        
        // When
        var resultToken: String?
        sut.login(user: user, password: password) { result in
            if case .success(let token) = result {
                resultToken = token
            }
            
        }
        
        // Then
        // El token recibido sea igual al expectedTokenMock y si lo son, el login es exitoso
        XCTAssertEqual(resultToken, expectedTokenMock)
    }
}
