//
//  DetailsViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit
import Kingfisher
class DetailsViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var titleDetails: UILabel!
    
    var viewType: Any!
    var indexPath: IndexPath!
    var viewModel: Results!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let view = viewType, let viewModel = viewModel else {return}
        setupView(viewType: view, vm: viewModel, indexPath: indexPath)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.topItem?.title = "Voltar"
        self.navigationController?.navigationBar.tintColor = ColorSystem.defaultElementsColor
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = ColorSystem.defaultBackgroundColor
    }
    
    
    func setupView(viewType: Any, vm: Results, indexPath: IndexPath){
        if let cv = viewType as? UICollectionView{
            if cv.tag == 100 {
                if let url = URL (string: vm.spotlight?[indexPath.row].bannerURL ?? "goK"){
                    imageView.kf.setImage(with: url)
                    titleDetails.text = vm.spotlight?[indexPath.row].name
                    descriptionDetails.numberOfLines = 0
                    descriptionDetails.text = vm.spotlight?[indexPath.row].description
                    
                }else{
                    imageView.image = UIImage(named: "goK")
                }
            }else {
                if let url = URL (string: vm.products?[indexPath.row].imageURL ?? "goK"){
                    imageView.kf.setImage(with: url)
                    titleDetails.text = vm.products?[indexPath.row].name
                    descriptionDetails.numberOfLines = 0
                    descriptionDetails.text = vm.products?[indexPath.row].description
                    
                }else{
                    imageView.image = UIImage(named: "goK")
                }
            }
        }else{
            //tableView
            if let url = URL (string: vm.cash?.bannerURL ?? "goK"){
                imageView.kf.setImage(with: url)
                titleDetails.text = vm.cash?.title
                descriptionDetails.numberOfLines = 0
                descriptionDetails.text = vm.cash?.description
                
            }else{
                imageView.image = UIImage(named: "goK")
            }
        }
        
        
    }

}
