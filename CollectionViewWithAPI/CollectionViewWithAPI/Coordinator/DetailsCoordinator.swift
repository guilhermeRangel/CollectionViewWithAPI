//
//  DetailsCoordinator.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import Foundation
import UIKit

class DetailsCoordinator: Coordinator {

    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let tabController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vcDetails = DetailsViewController.instantiate(Constants.Storyboard.detailsSB, id: Constants.Id.detailsId)
        vcDetails.coordinator = parentCoordinator
        navigationController.pushViewController(vcDetails, animated: true)
    }
    
    func goToDetails(result: Results, index: IndexPath) {
        let vc = DetailsViewController.instantiate(Constants.Storyboard.detailsSB, id: Constants.Id.detailsId)
        vc.coordinator = parentCoordinator
        vc.indexPath = index
        vc.viewModel = result
        navigationController.pushViewController(vc, animated: true)
    }
 
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
