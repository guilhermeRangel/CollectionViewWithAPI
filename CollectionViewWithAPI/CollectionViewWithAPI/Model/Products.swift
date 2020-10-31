//
//  Products.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
struct Products : Codable {
    let name : String?
    let imageURL : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case imageURL = "imageURL"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}

