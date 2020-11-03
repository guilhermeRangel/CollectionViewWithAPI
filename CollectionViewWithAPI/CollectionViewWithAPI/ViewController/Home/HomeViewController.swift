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
    private var topCollectionView: UICollectionView?
    private var bottomCollectionView: UICollectionView?
    private let widthScreen = UIScreen.main.bounds.width
    private let heighScreen = UIScreen.main.bounds.height
    
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.fetchProducts()
    
        layout = setupLayout(layout: layout)
        topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard var collectionView = topCollectionView, var bottomCollectionView = bottomCollectionView else {
            return
        }
        enableDelegates()
        collectionView.backgroundColor = .green
        collectionView.register(TopCustomCollectionViewCell.self, forCellWithReuseIdentifier: TopCustomCollectionViewCell.indentfier)
        setupCollectionView(collectionView: collectionView)
        view.addSubview(collectionView)
        collectionView = addContraints(collectionView: collectionView)

    }
    
    func enableDelegates(){
        viewModel.homeService.homeServiceDelegate = self
        topCollectionView?.delegate = self
        topCollectionView?.dataSource = self
    }
    func addContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.33).isActive = true
        return collectionView
    }
    
    
    func setupLayout(layout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
        layout.itemSize = CGSize(width: widthScreen, height: heighScreen)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
            self.topCollectionView?.reloadData()
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeModel.spotlight?.count ?? 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCustomCollectionViewCell.indentfier, for: indexPath) as! TopCustomCollectionViewCell
        
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
