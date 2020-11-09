//
//  HomeViewModel.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
struct HomeViewModel {
    var homeModel = Results()
    var homeService = HomeService()
    
    func fetchProducts(){
        homeService.fetchAllProducts()
    }
}
