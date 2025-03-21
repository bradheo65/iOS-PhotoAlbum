//
//  NetworkService.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func request<T: Decodable>(_ type: T.Type, _ urlRequest: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw NetworkError.statusCodeError
        }
        
        let element = try JSONDecoder().decode(T.self, from: data)
        return element
    }
    
}
