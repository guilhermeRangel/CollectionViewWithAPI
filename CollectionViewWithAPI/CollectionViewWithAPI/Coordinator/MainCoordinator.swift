//
//  MainCoordinator.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//


import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let tabController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Start Coordinator
    func start() {
        let child = HomeCoordinator(navigationController: navigationController)
        
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }
    
    func goToHome() {
        let child = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.goToHome()
    }
    
    func goToDetails(result: Results, viewType: Any, index: IndexPath){
        let child = DetailsCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        navigationController.isNavigationBarHidden = false
        child.parentCoordinator = self
        child.goToDetails(result: result, viewType: viewType, index: index)
    }

    
    // MARK: - Global Coordinator
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    //MARK: - Common
    func removeAllChild() {
        childCoordinators.removeAll()
       
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let homeViewController = fromViewController as? HomeViewController {
            childDidFinish(homeViewController.coordinator)
        }
        
        if let detailsViewController = fromViewController as? DetailsViewController {
            childDidFinish(detailsViewController.coordinator)
        }
        
        
    }
}

