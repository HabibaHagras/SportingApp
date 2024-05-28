//
//  HomeCollectionViewCell.swift
//  SportingApp
//
//  Created by habiba on 5/16/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Apply shadow to the cell
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 12)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        // Adjust appearance and layout
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        // Adjust label appearance
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        // Adjust image view content mode
        cellImg.contentMode = .scaleAspectFit
    }
}

