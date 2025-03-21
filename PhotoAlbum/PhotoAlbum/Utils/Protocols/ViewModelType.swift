//
//  ViewModelType.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation
import Combine

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
