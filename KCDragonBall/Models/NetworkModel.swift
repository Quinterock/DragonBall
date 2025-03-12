//
//  NetworkModel.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 5/3/25.
//

import Foundation

final class NetworkModel {
    static let shared = NetworkModel(client: APIClient.shared)
    
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    var token: String?
    
    init(client: APIClientProtocol) {
        self.client = client
    }
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, APIClientError>) -> Void
    ) {
        // Configurar la URL
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        
        // Encodifico el loginString con utf8
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.decodingFailed))
            return
        }
        
        let base64LoginData = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
        
        client.jwt(request) { [weak self] result in
            switch result {
                case let .success(token):
                    self?.token = token
                case .failure:
                    break
            }
            completion(result)
        }
    }
    
    func getHeroes(completion: @escaping (Result<[Hero], APIClientError>) -> Void) {
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let token else {
            completion(.failure(.unknown))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else {
            completion(.failure(.decodingFailed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = serializedBody
        
        client.request(request, using: [Hero].self, completion: completion)
    }
    
    func getTransformations(
        for hero: Hero, 
        completion: @escaping (Result<[Transformation], APIClientError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"

        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }

        guard let token else {
            completion(.failure(.unknown))
            return
        }

        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": hero.id]) else {
            completion(.failure(.decodingFailed))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = serializedBody
        
        client.request(request, using: [Transformation].self, completion: completion)
    }
}
