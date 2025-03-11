//
//  APIClientMock.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 6/3/25.
//

import Foundation
@testable import KCDragonBall

final class APIClientMock: APIClientProtocol {
    var didCallJWT = false
    var receivedTokenRequest: URLRequest?
    var receivedTokenResult: Result<String, APIClientError>?
    func jwt(
        _ request: URLRequest, 
        completion: @escaping (Result<String, APIClientError>) -> Void
    ) {
        didCallJWT = true
        receivedTokenRequest = request
        
        if let result = receivedTokenResult {
            completion(result)
        }
    }
    
    var didCallRequest = false
    var receivedRequest: URLRequest?
    var receivedHeroResult: Result<[Hero], APIClientError>?
    var receivedTransformationResult: Result<[Transformation], APIClientError>?
    func request<T>(
        _ request: URLRequest,
        using: T.Type, 
        completion: @escaping (Result<T, APIClientError>) -> Void
    ) where T : Decodable {
        didCallRequest = true
        receivedRequest = request
        
        if let heroResult = receivedHeroResult as? Result<T, APIClientError> {
            completion(heroResult)
            return
        }
        
        if let transformationResult = receivedTransformationResult as? Result<T, APIClientError> {
            completion(transformationResult)
            return
        }
    }
}
