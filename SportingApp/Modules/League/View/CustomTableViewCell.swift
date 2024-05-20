//
//  CustomTableViewCell.swift
//  NibFileCell
//
//  Created by maha on 5/15/24.
//  Copyright © 2024 maha. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCell.layer.borderWidth = 1.0
              imageCell.layer.borderColor = UIColor.black.cgColor
              imageCell.layer.cornerRadius = 8.0
              imageCell.clipsToBounds = true
    }

 
    
}
