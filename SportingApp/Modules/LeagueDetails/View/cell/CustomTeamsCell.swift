//
//  CustomTeamsCell.swift
//  SportingApp
//
//  Created by maha on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class CustomTeamsCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNameLB: UILabel!
  
    override func awakeFromNib() {
         super.awakeFromNib()
        
         makeImageCircular()
     }

     private func makeImageCircular() {
         teamImage.layer.cornerRadius = teamImage.frame.size.width / 2
         teamImage.clipsToBounds = true
     }

     override func layoutSubviews() {
         super.layoutSubviews()

         makeImageCircular()
     }

}
