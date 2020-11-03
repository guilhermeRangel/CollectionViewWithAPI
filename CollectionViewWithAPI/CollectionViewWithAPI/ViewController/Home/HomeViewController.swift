//
//  ViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, Storyboarded {
    
    private var layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView?

    private let widthScreen = UIScreen.main.bounds.width
    private let heighScreen = UIScreen.main.bounds.height
    
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProducts()
    
        layout = setupLayout(layout: layout)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard var collectionView = collectionView else {
            return
        }
        enableDelegates()
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.indentfier)
        setupCollectionView(collectionView: collectionView)
        view.addSubview(collectionView)
        collectionView = addContraints(collectionView: collectionView)

    }
    
    func enableDelegates(){
        viewModel.homeService.homeServiceDelegate = self
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    func addContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen/3).isActive = true
        return collectionView
    }
    
    
    func setupLayout(layout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
        layout.itemSize = CGSize(width: widthScreen, height: heighScreen/3)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -10
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
    
    
}
extension HomeViewController: HomeServiceDelegate{
    func onHomeFetched(_ result: Results) {
        viewModel.homeModel = result
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeModel.spotlight?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.indentfier, for: indexPath) as! CustomCollectionViewCell
        
        if let url = URL (string: viewModel.homeModel.spotlight?[indexPath.row].bannerURL ?? ""){
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func setupCollectionView(collectionView: UICollectionView){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
    }
    
}
