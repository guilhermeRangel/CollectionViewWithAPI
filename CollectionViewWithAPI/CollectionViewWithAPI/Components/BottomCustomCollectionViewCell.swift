//
//  BottomCustomCollectionViewCell.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 03/11/20.
//

import UIKit

class BottomCustomCollectionViewCell: UICollectionViewCell {
    static let indentfier = "BottomCustomCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
        contentView.addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError("coder has not implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        contentView.clipsToBounds = true
    }
}
