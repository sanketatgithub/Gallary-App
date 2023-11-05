//
//  GallaryViewModel.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation
import Combine

class GallaryViewModel: ObservableObject {
    var repository: RemoteGallaryProtocol
    
    var offset = 0
    var limit = 20
    var isLoading = false
    var totalPhotos: Int = 0
    
    @Published var photos: [PhotoModel]?
    @Published var errorMessage: String?
    
    init(repository: RemoteGallaryProtocol = GallaryRepository()) {
        self.repository = repository
    }
    
    func numberOfItems() -> Int {
        return (self.photos ?? []).count
    }
    
    func getItem(indexPath: IndexPath) -> PhotoModel? {
        guard let photos = self.photos else { return nil}
        
        if indexPath.item >= 0 && indexPath.item < photos.count {
            return photos[indexPath.item]
        }
        
        return nil
    }
    
    func updateOffsetAndLimit() {
        let totalPages = Float((self.totalPhotos/self.limit)).rounded(.toNearestOrAwayFromZero)
        
        if Float(self.offset) < totalPages {
            self.offset += 1
        } else {
            self.offset = 0
        }
    }
    
    func fetchGallaryPhotos() async {
        do {
            self.isLoading = true
            let response = try await repository.fetchGallaryImages(offset: offset, limit: limit)
            self.totalPhotos = response.totalPhotos ?? 0
            
            let photos = ModelMapper.getPhotos(response: response)
            if offset == 0 {
                self.photos = photos
            } else {
                self.photos?.append(contentsOf: photos)
            }
            self.isLoading = false
        } catch let exception {
            self.errorMessage = exception.localizedDescription
            self.isLoading = false
        }
    }
}
