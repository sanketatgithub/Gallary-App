//
//  ImageCache.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.totalCostLimit = 20 * 1024 * 1024 // Limit the cache size to 20 MB
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}


