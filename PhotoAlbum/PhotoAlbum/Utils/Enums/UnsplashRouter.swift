//
//  UnsplashRouter.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation

enum UnsplashRouter {
    case getPhotos(page: String, perPage: String)
}

extension UnsplashRouter: NetworkRouterProtocol {
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return "/photos"
        }
    }
    
    var headers: [[String: String]] {
        let headers = [
            ["Content-Type": "application/json"],
            ["Authorization": "Client-ID mnA7d-LbkEqY7HHVL09SIIkwrxSjUH7DDqCPgMKrBVA"]
        ]
        return headers
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getPhotos(let page, let perPage):
            let queryItems: [URLQueryItem] = [
                .init(name: "page", value: page),
                .init(name: "per_page", value: perPage)
            ]
            return queryItems
        }
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var requestBody: Data? {
        switch self {
        case .getPhotos:
            return nil
        }
    }
}
