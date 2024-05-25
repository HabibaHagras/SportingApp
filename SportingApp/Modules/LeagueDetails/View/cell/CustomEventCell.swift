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

    @IBOutlet weak var homeTeamLB: UILabel!
    
    @IBOutlet weak var awayTeamLB: UILabel!
    @IBOutlet weak var timeLB: UILabel!
    
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var resultLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
         setupView()
        //imageCell.layer.borderWidth = 1.0
//              imageCell.layer.borderColor = UIColor.black.cgColor
//              imageCell.layer.cornerRadius = 8.0
//              imageCell.clipsToBounds = true
    }
 
    
    private func setupView() {
        // Customize the content view
        self.contentView.layer.cornerRadius = 10  // Set your desired corner radius
        self.contentView.layer.masksToBounds = true
        
        // Optionally customize any other subview
        if let customBackgroundView = self.backgroundView {
            customBackgroundView.layer.cornerRadius = 10
            customBackgroundView.layer.masksToBounds = true
        }
        imageCell.layer.cornerRadius = imageCell.frame.width / 2
        imageCell.layer.masksToBounds = true
        awayImage.layer.cornerRadius = awayImage.frame.width / 2
        awayImage.layer.masksToBounds = true
    }

 
    
}
