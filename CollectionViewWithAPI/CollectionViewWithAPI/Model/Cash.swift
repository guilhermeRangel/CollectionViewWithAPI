//
//  Cash.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

struct Cash : Codable {
    let title : String?
    let bannerURL : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case bannerURL = "bannerURL"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        bannerURL = try values.decodeIfPresent(String.self, forKey: .bannerURL)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}
