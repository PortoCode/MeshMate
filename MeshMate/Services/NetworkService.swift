//
//  NetworkService.swift
//  MeshMate
//
//  Created by Rodrigo Porto on 25/05/25.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchNetworkData(completion: @escaping (Result<NetworkResponse, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "mock_response", withExtension: "json") else {
            completion(.failure(NSError(domain: "FileNotFound", code: 404)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(NetworkResponse.self, from: data)
            completion(.success(response))
        } catch {
            completion(.failure(error))
        }
    }
}
