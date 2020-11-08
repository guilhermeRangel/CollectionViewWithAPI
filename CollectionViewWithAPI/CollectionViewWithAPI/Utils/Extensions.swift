//
//  Extensions.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//


import Foundation
import UIKit

// MARK: - NSObject

extension NSObject {
    static var name: String {
        return String(describing: self)
    }
}

// MARK: - Encodable

extension Encodable {
    func toDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self.self)
        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return json as? [String: Any] ?? [:]
    }
}

// MARK: - Decodable

extension Decodable {
    static func fromDictionary(_ object: Any) -> Self? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            return try JSONDecoder().decode(self.self, from: data)
        } catch {
            print(error)
        }
        return nil
    }
}
// MARK: - String

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension UIView {
    func setRadiusWithShadow(_ radius: CGFloat? = nil, shadow: CGFloat? = nil, shadowOp: Float? = nil) {
        layer.cornerRadius = radius ?? 4
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowRadius = shadow ?? 1.0
        layer.shadowOpacity = shadowOp ?? 0.7
        layer.masksToBounds = false
    }

}
