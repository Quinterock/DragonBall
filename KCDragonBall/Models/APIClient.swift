//
//  APIClient.swift
//  KCDragonBall
//
//  Created by Luis Quintero on 5/3/25.
//

import Foundation

enum APIClientError: Error, Equatable {
    case malformedURL
    case noData
    case statusCode(code: Int?)
    case decodingFailed
    case unknown
}

// 1. Primer paso para controlar una dependencia. Empaquetarla en un protocolo
protocol APIClientProtocol {
    func jwt(
        _ request: URLRequest, 
        completion: @escaping (Result<String, APIClientError>) -> Void
    )
    
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, APIClientError>) -> Void
    )
}

struct APIClient: APIClientProtocol {
    static let shared = APIClient()
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Con este metodo vamos a obtener el JWT de la API
    func jwt(
        _ request: URLRequest, 
        completion: @escaping (Result<String, APIClientError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            // Compruebo si hay un error
            guard error == nil else {
                // Si el error existe, lo envio al completion
                if let error = error as? NSError {
                    completion(.failure(.statusCode(code: error.code)))
                } else {
                    completion(.failure(.unknown))
                }
                return
            }
            
            // Compruebo si hay data
            guard let data else {
                // Si no hay data, envio el error `.noData`
                completion(.failure(.noData))
                return
            }
            
            let response = response as? HTTPURLResponse
            
            // Compruebo si la respuesta es satisfactoria, es decir, el codigo es 200
            guard let response, response.statusCode == 200 else {
                completion(.failure(.statusCode(code: response?.statusCode)))
                return
            }
            
            guard let jwt = String(data: data, encoding: .utf8) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(jwt))
        }
        
        task.resume()
    }
    
    // Lo usaremos con Hero y con Transformation
    // Para este metodo request, T va a ser Decodable
    // Para el parametro using, T.Type, sera tanto Hero como Transformation
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, APIClientError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                if let error = error as? NSError {
                    completion(.failure(.statusCode(code: error.code)))
                } else {
                    completion(.failure(.unknown))
                }
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            let response = response as? HTTPURLResponse
            
            guard let response, response.statusCode == 200 else {
                completion(.failure(.statusCode(code: response?.statusCode)))
                return
            }
            
            guard let decodedModel = try? JSONDecoder().decode(using, from: data) else {
                completion(.failure(.decodingFailed))
                return
            }
            
            completion(.success(decodedModel))
        }
        
        task.resume()
    }
}
