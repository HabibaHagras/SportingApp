//
//  FavoriteTableViewCell.swift
//  SportingApp
//
//  Created by habiba on 5/25/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var labelFav: UILabel!
    
    @IBOutlet weak var youtupeImg: UIImageView!
    @IBOutlet weak var ImgFav: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
