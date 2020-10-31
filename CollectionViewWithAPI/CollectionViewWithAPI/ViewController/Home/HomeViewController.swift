//
//  ViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home")
        viewModel.homeService.homeServiceDelegate = self
        self.view.backgroundColor = .blue
    }

    @IBAction func btnNextPage(_ sender: UIButton) {
        
        viewModel.fetchProducts()
    }
    
}
extension HomeViewController: HomeServiceDelegate{
    func onHomeFetched(_ result: Results) {
        print(result)
    }
    
   
    
    
}

