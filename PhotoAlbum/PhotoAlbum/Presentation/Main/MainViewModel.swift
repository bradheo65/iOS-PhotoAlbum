//
//  MainViewModel.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation

final class MainViewModel {
    func fetchImageList(page: String, perPage: String) async throws {
        let urlRequest = UnsplashRouter.getPhotos(
            page: page,
            perPage: perPage
        ).asURLRequest()
        
        let result = try await NetworkService.shared.request(
            [ImageInfo].self,
            urlRequest
        )
        print(result)
    }
}
