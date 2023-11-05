//
//  Photos.swift
//  GallaryApp
//
//  Created by Sanket Patil on 04/11/23.
//

import Foundation
struct Photos: Codable {
	let description: String?
	let url: String
	let title: String
	let id: Int
	let user: Int?

	enum CodingKeys: String, CodingKey {

		case description
		case url
		case title
		case id
		case user
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
		id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
		user = try values.decodeIfPresent(Int.self, forKey: .user)
	}

}
