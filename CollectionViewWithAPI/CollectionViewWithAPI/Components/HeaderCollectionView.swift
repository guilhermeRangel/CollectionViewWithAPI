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
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.sizeToFit()
//        label.backgroundColor = .purple
         return label
     }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "goK")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
     override init(frame: CGRect) {
       super.init(frame: frame)
  
       self.addSubview(label)
        self.addSubview(imageView)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
     
        
      
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
