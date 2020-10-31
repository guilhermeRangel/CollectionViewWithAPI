//
//  HomeService.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation


protocol HomeServiceProtocol: class {
    func fetchAllProducts()
}

protocol HomeServiceDelegate {
    func onHomeFetched(_ result: Results)
}

class HomeService: HomeServiceProtocol {
    var homeServiceDelegate: HomeServiceDelegate?
    
    func fetchAllProducts(){
        EventService<Results>.fetchProducts.request { result in
            switch result {
            case let .success(result):
                DispatchQueue.main.async{
                    self.homeServiceDelegate?.onHomeFetched(result)
                }
                
            case .failure:
                break
            }
        }
    }
}
