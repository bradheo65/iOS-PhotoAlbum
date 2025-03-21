//
//  ImageInfo.swift
//  PhotoAlbum
//
//  Created by HEOGEON on 3/21/25.
//

import Foundation

struct ImageInfo: Decodable {
    let urls: URLs
}

struct URLs: Decodable {
    let regular: String
}
