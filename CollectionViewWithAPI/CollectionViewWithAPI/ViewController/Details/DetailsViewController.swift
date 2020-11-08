//
//  DetailsViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit

class DetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var viewModel: Results!
    var indexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {return}
        print(viewModel.products)
    }
    

}
