//
//  Data+Extension.swift
//  GallaryApp
//
//  Created by Sanket Patil on 05/11/23.
//

import Foundation

extension Data {
    func decodeData<T: Decodable>(_ type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(type, from: self)
            return decodedObject
        } catch {
            throw DecodingError.decodingFailed
        }
    }
}
