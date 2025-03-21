//
//  NetworkRouterProtocol.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation


protocol NetworkRouterProtocol {
    var baseURL: String { get }
    var path: String { get }
    var headers: [[String: String]] { get }
    var httpMethod: HttpMethod { get }
    var parameters: [URLQueryItem]? { get }
    var requestBody: Data? { get }
    
    func asURLRequest() -> URLRequest
}

extension NetworkRouterProtocol {
    func asURLRequest() -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = parameters
        guard let url = components?.url else {
            fatalError("Invalid URL: \(baseURL + path)")
        }
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { value in
            value.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        return urlRequest
    }
}
