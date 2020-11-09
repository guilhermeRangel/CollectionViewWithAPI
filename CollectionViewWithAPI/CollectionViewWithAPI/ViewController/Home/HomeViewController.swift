//
//  ViewController.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 31/10/20.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, Storyboarded {
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private var layoutTop = UICollectionViewFlowLayout()
    private var layoutBottom = UICollectionViewFlowLayout()
    
    private var topCollectionView: UICollectionView?
    private var bottomCollectionView: UICollectionView?
    private var tableView = UITableView()
    
    private let widthScreen = UIScreen.main.bounds.width
    private let heighScreen = UIScreen.main.bounds.height
    
    weak var coordinator: MainCoordinator?
    var viewModel = HomeViewModel()
    
    var alert = Alerts()
    //flag to when be not connected
    var repeats = true
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        
        layoutTop = setupTopLayout(layout: layoutTop)
        layoutBottom = setupBottomLayout(layout: layoutBottom)
        
     
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
        
//        if let topFlowLayout = topCollectionView.collectionViewLayout as? UICollectionViewFlowLayout , let bottomFlowLayout = bottomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout{
//
//            topFlowLayout.sectionHeadersPinToVisibleBounds = true
//            bottomFlowLayout.sectionHeadersPinToVisibleBounds = true
//
//        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //open a thread and test the connectivity
    
        checkConectivity()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
}

extension HomeViewController {
    
  
    func setupTableView(tableView: UITableView) -> UITableView{
        tableView.isScrollEnabled = false
        return tableView
    }
    // MARK: - Registers Cells
    func  registerCustomCell(){
        topCollectionView?.register(TopCustomCollectionViewCell.self, forCellWithReuseIdentifier: TopCustomCollectionViewCell.indentfier)

        bottomCollectionView?.register(BottomCustomCollectionViewCell.self, forCellWithReuseIdentifier: BottomCustomCollectionViewCell.indentfier)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.indentfier)
        
        self.topCollectionView?.register(HeaderCollectionView.self, forSupplementaryViewOfKind:
                                            UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.indentfier)
        
        self.bottomCollectionView?.register(HeaderCollectionView.self, forSupplementaryViewOfKind:
                                                UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.indentfier)
        
        
    }
    func showActivityIndicator() {
       
        self.activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        activityView.isHidden = false
    }

    func hideActivityIndicator(){
      
            activityView.stopAnimating()
            activityView.isHidden = true
        
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.3).isActive = true
        collectionView.backgroundColor = .red
        collectionView.layer.cornerRadius = 15
        return collectionView
    }
    
    
    func addBottoContraints(collectionView: UICollectionView) -> UICollectionView{
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: heighScreen * 0.3).isActive = true
        collectionView.layer.cornerRadius = 15
        collectionView.backgroundColor = .yellow
        return collectionView
    }
    
    func addTableViewContraints(tableView: UITableView) -> UITableView{
        tableView.topAnchor.constraint(equalTo: topCollectionView!.bottomAnchor, constant: 16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomCollectionView!.topAnchor, constant: -16).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -8).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
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
    
    func checkConectivity(){
        if CheckConnectivity.isConnectedToInternet{
            viewModel.fetchProducts()
            self.repeats = false
            
        }else{
            let result = alert.alertOffline()
            present(result, animated: true, completion: {
                
                Timer.scheduledTimer(withTimeInterval: 10, repeats: self.repeats) { (_) in
                    self.viewModel.fetchProducts()
                    self.tableView.reloadData()
                    self.topCollectionView?.reloadData()
                    self.bottomCollectionView?.reloadData()
                    self.repeats = true
                }
            })
        }
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
        tableView.bounds.height / 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel.homeModel.cash?.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.indentfier, for: indexPath as IndexPath) as! CustomTableViewCell
        if let url = URL (string: viewModel.homeModel.cash?.bannerURL ?? "goK"){
            cell.imageView?.kf.setImage(with: url)
        }
        
//        tableView.selectionStyle = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToDetails(result: viewModel.homeModel, viewType: tableView, index: indexPath)
    }
    
}

//MARK: - HomeServiceDelegate
extension HomeViewController: HomeServiceDelegate{
    func onHomeFetched(_ result: Results) {
        viewModel.homeModel = result
        showActivityIndicator()
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
            self.bottomCollectionView?.reloadData()
            self.tableView.reloadData()
            self.hideActivityIndicator()
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
        print("\(indexPath.row)")
        coordinator?.goToDetails(result: viewModel.homeModel, viewType: collectionView, index: indexPath)
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
                return cell
            }
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
            
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height * 0.5)
    }
    
}
