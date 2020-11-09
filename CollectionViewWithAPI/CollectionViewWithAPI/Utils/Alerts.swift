//
//  Alerts.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 08/11/20.
//

import Foundation
import UIKit

struct Alerts {
    func alertOffline() -> UIAlertController {
        let alert = UIAlertController(title: "Você esta Offline", message: "Parece que você está sem conexão no momento, restabeleça a conexão e tente novamente", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Entendi".localized, style: .cancel, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
