//
//  PhotoModel.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation

struct PhotoModel {
    var id: Int
    var title: String
    var url: String
    
    init(id: Int, title: String, url: String) {
        self.id = id
        self.title = title
        self.url = url
    }
}
