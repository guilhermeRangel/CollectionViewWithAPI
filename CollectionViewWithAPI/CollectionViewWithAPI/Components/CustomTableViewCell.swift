//
//  CustomTableViewCell.swift
//  CollectionViewWithAPI
//
//  Created by Guilherme Rangel on 04/11/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let indentfier = "CustomTableViewCell"
   
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .gray
       
        contentView.addSubview(cashImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    let cashImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loading")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
}
