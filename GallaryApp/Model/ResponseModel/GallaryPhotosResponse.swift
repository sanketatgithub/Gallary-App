//
//  GallaryPhotosResponse.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation
struct GallaryPhotosResponse: Codable {
	let success: Bool?
	let totalPhotos: Int?
	let message: String?
	let offset: Int?
	let limit: Int?
	let photos: [Photos]?

	enum CodingKeys: String, CodingKey {

		case success
		case totalPhotos = "total_photos"
		case message
		case offset
		case limit
		case photos
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
        totalPhotos = try values.decodeIfPresent(Int.self, forKey: .totalPhotos)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		offset = try values.decodeIfPresent(Int.self, forKey: .offset)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		photos = try values.decodeIfPresent([Photos].self, forKey: .photos)
	}

}
