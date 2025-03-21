//
//  MainViewModel.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation
import Combine

final class MainViewModel: ViewModelType {
    enum Input {
        case viewWillAppear
    }
    
    enum Output {
        case getImageList([ImageInfo])
        case failure(Error)
    }
    
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewWillAppear:
                self?.fetchImageList(page: "1", perPage: "10")
            }
        }
        .store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }

}

private extension MainViewModel {
    func fetchImageList(page: String, perPage: String) {
        let urlRequest = UnsplashRouter.getPhotos(
            page: page,
            perPage: perPage
        ).asURLRequest()
        
        Task {
            do {
                let result = try await NetworkService.shared.request(
                    [ImageInfo].self,
                    urlRequest
                )
                output.send(.getImageList(result))
            } catch {
                output.send(.failure(error))
            }
        }
    }
}
