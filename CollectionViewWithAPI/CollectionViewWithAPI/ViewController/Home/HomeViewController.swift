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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home")
        self.view.backgroundColor = .blue
    }

    @IBAction func btnNextPage(_ sender: UIButton) {
        
        coordinator?.goToDetails()
    }
    
}

