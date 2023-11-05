//
//  ThrowableError.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation

enum ThrowableError: Error {
    case customError(message: String)
}

enum DecodingError: Error {
    case decodingFailed
}
