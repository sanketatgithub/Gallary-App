//
//  GallaryImageCollectionViewCell.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import UIKit

class GallaryImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "GallaryImageCollectionViewCell"
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func configure(photo: PhotoModel) {
        self.titleLabel.text = photo.title
        guard let url = URL(string: photo.url) else { return }
        self.photoImageView.image = nil
        self.photoImageView.loadImage(url: url)
    }
}
