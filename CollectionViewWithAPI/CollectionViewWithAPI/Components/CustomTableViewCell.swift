//
//  CustomTableViewCell.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 04/11/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let indentfier = "CustomTableViewCell"
   
    let cashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = ColorSystem.defaultBackgroundColor
        contentView.addSubview(cashImage)
        cashImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cashImage.frame = CGRect(x: .zero, y: .zero,
                                 width: contentView.frame.size.width,
                                 height: contentView.frame.size.height)
  
    
    }

}
