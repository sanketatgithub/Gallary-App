//
//  GallaryRepository.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation

protocol RemoteGallaryProtocol {
    func getFetchPhotoServiceUrl(offset: Int, limit: Int) throws -> URL
    func fetchGallaryImages(offset: Int, limit: Int) async throws -> GallaryPhotosResponse
}

class GallaryRepository {
    var manager: NetworkManagerProtocol
    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }
}

extension GallaryRepository: RemoteGallaryProtocol {
    
    func getFetchPhotoServiceUrl(offset: Int, limit: Int) throws -> URL {
        guard let url = URL(string: "\(Service.photos.path)?offset=\(offset)&limit=\(limit)") else {
            throw ThrowableError.customError(message: "Failed to compose URL with path.")
        }
        
        return url
    }
    
    func fetchGallaryImages(offset: Int, limit: Int) async throws -> GallaryPhotosResponse {
        do {
            let url = try getFetchPhotoServiceUrl(offset: offset, limit: limit)
            let result = await self.manager.performServiceRequest(url: url)
            
            switch result {
            case .success(let data):
                return try data.decodeData(GallaryPhotosResponse.self)
            case .failure(let error):
                throw error
            }
        } catch let exception {
            throw exception
        }
    }
}
