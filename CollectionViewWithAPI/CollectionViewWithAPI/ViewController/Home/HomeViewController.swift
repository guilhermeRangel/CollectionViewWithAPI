//
//  ViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, Storyboarded {
    
    private var layoutTop = UICollectionViewFlowLayout()
    private var layoutBottom = UICollectionViewFlowLayout()
    
    private var topCollectionView: UICollectionView?
    private var bottomCollectionView: UICollectionView?
    
    private let widthScreen = UIScreen.main.bounds.width
    private let heighScreen = UIScreen.main.bounds.height
    
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProducts()
    
        layoutTop = setupLayout(layout: layoutTop)
        layoutBottom = setupLayout2(layout: layoutBottom)
        
        topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutTop)
        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutBottom)
        
        guard var topCollectionView = topCollectionView,
              var bottomCollectionView = bottomCollectionView else {
            return
        }
        enableDelegates()
        registerCollections()
   
        setupCollectionView(collectionView: topCollectionView)
        setupCollectionView(collectionView: bottomCollectionView)
        
        topCollectionView.tag = 100
        bottomCollectionView.tag = 200
        
        view.addSubview(topCollectionView)
        view.addSubview(bottomCollectionView)
        
        topCollectionView = addTopContraints(collectionView: topCollectionView)
        bottomCollectionView = addBottoContraints(collectionView: bottomCollectionView)

    }
    
    func registerCollections(){
        topCollectionView?.register(TopCustomCollectionViewCell.self, forCellWithReuseIdentifier: TopCustomCollectionViewCell.indentfier)
        
        bottomCollectionView?.register(BottomCustomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCustomCollectionViewCell.indentfier)
        
    }
    
    func enableDelegates(){
        viewModel.homeService.homeServiceDelegate = self
        topCollectionView?.delegate = self
        topCollectionView?.dataSource = self
        
        bottomCollectionView?.delegate = self
        bottomCollectionView?.dataSource = self
    }
    
    
    func addTopContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.33).isActive = true
        return collectionView
    }
    
    
    func addBottoContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.25).isActive = true
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
    func setupLayout2(layout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
        layout.itemSize = CGSize(width: widthScreen * 0.8, height: heighScreen)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -(widthScreen / 3)
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
    
    
    
}
extension HomeViewController: HomeServiceDelegate{
    func onHomeFetched(_ result: Results) {
        viewModel.homeModel = result
        
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
            self.bottomCollectionView?.reloadData()
        }
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == topCollectionView?.tag{
            return viewModel.homeModel.spotlight?.count ?? 2
        }else{
            return viewModel.homeModel.products?.count ?? 3
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == topCollectionView?.tag{
        
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCustomCollectionViewCell.indentfier, for: indexPath) as! TopCustomCollectionViewCell
            
            if let url = URL (string: viewModel.homeModel.spotlight?[indexPath.row].bannerURL ?? ""){
                cell.imageView.kf.setImage(with: url)
            }
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCustomCollectionViewCell.indentfier, for: indexPath) as! BottomCustomCollectionViewCell
            
            if let url = URL (string: viewModel.homeModel.products?[indexPath.row].imageURL ?? ""){
                cell.imageView.kf.setImage(with: url)
                
        }
            return cell
        }
       
        
    }
    
    func setupCollectionView(collectionView: UICollectionView){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
    }
    
}
