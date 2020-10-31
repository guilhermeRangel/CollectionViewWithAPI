//
//  Spotlight.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
struct Spotlight : Codable {
    let name : String?
    let bannerURL : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case bannerURL = "bannerURL"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        bannerURL = try values.decodeIfPresent(String.self, forKey: .bannerURL)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
