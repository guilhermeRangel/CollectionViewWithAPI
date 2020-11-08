//
//  ColorSystem.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 07/11/20.
//

import Foundation
import UIKit

class ColorSystem {
    static var defaultBackgroundColor: UIColor{
        return UIColor.init(named: "DefaultBackgroundColor") ?? UIColor.init(red: 0.175, green: 0.186, blue: 0.231, alpha: 1)
    }
    static var defaultElementsColor:UIColor {
        return UIColor(named: "DefaultElementsColor") ?? .gray
    }
    static var defaultElementeCell:UIColor {
        return UIColor(named: "DefaultElementeCell") ?? .gray
    }
    static var backgroundCard:UIColor {
        return UIColor(named: "BackgroundCard") ?? .gray
    }
    
    
    func getColor(name: String) -> UIColor{
        return UIColor.init(named: name) ?? .gray
    }
    
}

