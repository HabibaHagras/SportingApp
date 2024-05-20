//
//  LeagueTableViewCell.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLeague: UIImageView!
    @IBOutlet weak var labelLeagueCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgLeague.layer.cornerRadius = imgLeague.frame.size.width/2
        imgLeague.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        imgLeague.layer.cornerRadius = imgLeague.bounds.width / 2
        imgLeague.clipsToBounds = true

    }

}
