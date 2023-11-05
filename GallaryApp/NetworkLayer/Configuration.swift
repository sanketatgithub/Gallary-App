//
//  Configuration.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation

struct Configuration {
    static let BaseUrl = "https://api.slingacademy.com/v1/sample-data/"
}

enum Service {
    case photos
    
    var name: String {
        switch self {
        case .photos:
            return "photos"
        }
    }
    
    var path: String {
        switch self {
        case .photos:
            return "\(Configuration.BaseUrl)\(self.name)"
        }
    }
}
