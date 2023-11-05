//
//  UIImageView+Extension.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                ImageCache.shared.setImage(image, forKey: url.absoluteString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
