//
//  HeaderCollectionView.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 08/11/20.
//

import Foundation
import UIKit
class HeaderCollectionView: UICollectionReusableView  {
    static let indentfier = "HeaderCollectionView"
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = ColorSystem.defaultElementsColor
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "goK")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(label)
        self.addSubview(imageView)
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
//        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
//
        
        
        
  
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 8, y: 8, width: 50, height: 50)
       
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
