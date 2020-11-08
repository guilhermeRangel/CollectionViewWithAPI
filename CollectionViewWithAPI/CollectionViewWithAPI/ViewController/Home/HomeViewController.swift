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
    private var tableView = UITableView()
    
    private let widthScreen = UIScreen.main.bounds.width
    private let heighScreen = UIScreen.main.bounds.height
    
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProducts()
    
        layoutTop = setupTopLayout(layout: layoutTop)
        layoutBottom = setupBottomLayout(layout: layoutBottom)
        
        // react
        topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutTop)
        bottomCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutBottom)
        tableView.frame = CGRect(x: .zero, y: .zero, width: widthScreen, height: heighScreen)
        
       
        guard var topCollectionView = topCollectionView,
              var bottomCollectionView = bottomCollectionView else {
            return
        }
        enableDelegates()
        registerCustomCell()
   
        setupCollectionView(collectionView: topCollectionView)
        setupCollectionView(collectionView: bottomCollectionView)
        
        topCollectionView.tag = 100
        bottomCollectionView.tag = 200
        
        view.addSubview(topCollectionView)
        view.addSubview(bottomCollectionView)
        view.addSubview(tableView)
        
        
        topCollectionView = addTopContraints(collectionView: topCollectionView)
        bottomCollectionView = addBottoContraints(collectionView: bottomCollectionView)
        tableView = setupTableView(tableView: tableView)
        tableView = addTableViewContraints(tableView: tableView)
        
    

    }
    
}

extension HomeViewController {
    
    func setupTableView(tableView: UITableView) -> UITableView{
        tableView.isScrollEnabled = false
        return tableView
    }
    // MARK: - Registers
    func  registerCustomCell(){
        //header
       
        topCollectionView?.register(TopCustomCollectionViewCell.self, forCellWithReuseIdentifier: TopCustomCollectionViewCell.indentfier)
        
     

        
        bottomCollectionView?.register(BottomCustomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCustomCollectionViewCell.indentfier)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.indentfier)
        

        self.topCollectionView?.register(HeaderCollectionView.self, forSupplementaryViewOfKind:
                                        UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.indentfier)
        
        self.bottomCollectionView?.register(HeaderCollectionView.self, forSupplementaryViewOfKind:
                                        UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.indentfier)
        
    }
    func enableDelegates(){
        viewModel.homeService.homeServiceDelegate = self
        topCollectionView?.delegate = self
        topCollectionView?.dataSource = self
        
        bottomCollectionView?.delegate = self
        bottomCollectionView?.dataSource = self
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    
    func addTopContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.33).isActive = true
        collectionView.backgroundColor = .red
        return collectionView
    }
    
    
    func addBottoContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.33).isActive = true
        collectionView.backgroundColor = .yellow
        return collectionView
    }
    
    func addTableViewContraints(tableView: UITableView) -> UITableView{
        tableView.topAnchor.constraint(equalTo: topCollectionView!.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomCollectionView!.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
 
        return tableView
    }
    
    
    func setupTopLayout(layout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
        layout.itemSize = CGSize(width: widthScreen, height: heighScreen)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -10
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
    func setupBottomLayout(layout: UICollectionViewFlowLayout) -> UICollectionViewFlowLayout{
        layout.itemSize = CGSize(width: widthScreen * 0.8, height: heighScreen)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = -(widthScreen / 3)
        layout.minimumInteritemSpacing = 0
        
        return layout
    }
    
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = ColorSystem.defaultBackgroundColor
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        tableView.bounds.height
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        viewModel.homeModel.cash?.title
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentfier, for: indexPath as IndexPath) as! CustomTableViewCell
        if let url = URL (string: viewModel.homeModel.cash?.bannerURL ?? "goK"){
            cell.imageView?.kf.setImage(with: url)
        }
//        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetails(result: viewModel.homeModel, index: indexPath)
    }
    
}

//MARK: - HomeServiceDelegate
extension HomeViewController: HomeServiceDelegate{
    func onHomeFetched(_ result: Results) {
        viewModel.homeModel = result
        
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
            self.bottomCollectionView?.reloadData()
            self.tableView.reloadData()
        }
        
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == topCollectionView?.tag{
            return viewModel.homeModel.spotlight?.count ?? 2
        }else if collectionView.tag == bottomCollectionView?.tag{
            return viewModel.homeModel.products?.count ?? 3
        }else{
            fatalError()
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        coordinator?.goToDetails(result: viewModel.homeModel, index: indexPath)
    }
    

 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
     
        
        if collectionView.tag == topCollectionView?.tag{
        
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCustomCollectionViewCell.indentfier, for: indexPath) as! TopCustomCollectionViewCell
            
            if let url = URL (string: viewModel.homeModel.spotlight?[indexPath.row].bannerURL ?? "goK"){
                cell.imageView.kf.setImage(with: url)
            }
     
            
            return cell
        }else if collectionView.tag == bottomCollectionView?.tag{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomCustomCollectionViewCell.indentfier, for: indexPath) as! BottomCustomCollectionViewCell
            
            if let url = URL (string: viewModel.homeModel.products?[indexPath.row].imageURL ?? "goK"){
                cell.imageView.kf.setImage(with: url)
                
        }
            return cell
        }else{
            print("alo")
        }
        
        return UICollectionViewCell()
    }
    
    
    
    func setupCollectionView(collectionView: UICollectionView){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionView.indentfier, for: indexPath) as! HeaderCollectionView
            
            
            if collectionView.tag == topCollectionView?.tag{
                sectionHeader.label.text = viewModel.homeModel.spotlight?[indexPath.row].name
            }else{
                sectionHeader.label.text = viewModel.homeModel.products?[indexPath.row].name
            }
            
            
            
             return sectionHeader
        } else { //No footer in this case but can add option for that
             return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 30.0)
    }
    
}
