//
//  Results.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
struct Results : Codable {
    let spotlight : [Spotlight]?
    let products : [Products]?
    let cash : Cash?

    enum CodingKeys: String, CodingKey {

        case spotlight = "spotlight"
        case products = "products"
        case cash = "cash"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        spotlight = try values.decodeIfPresent([Spotlight].self, forKey: .spotlight)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        cash = try values.decodeIfPresent(Cash.self, forKey: .cash)
    }

}
