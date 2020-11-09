//
//  CheckConnectivity.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 08/11/20.
//

// simple reab
import Alamofire
import Foundation

struct CheckConnectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return sharedInstance.isReachable
    }
}
