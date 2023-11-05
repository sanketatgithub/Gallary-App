//
//  ModelMapper.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation

struct ModelMapper {
    static func getPhotos(response: GallaryPhotosResponse) -> [PhotoModel] {
        return response.photos?.compactMap { PhotoModel(id: $0.id, title: $0.title, url: $0.url)} ?? []
    }
}
