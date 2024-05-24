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
        super.layoutSubviews()
        imgLeague.round()
        imgLeague.layer.cornerRadius = imgLeague.bounds.width / 2
        imgLeague.clipsToBounds = true

    }

}
extension UIView {
    func round() {
        let scaleFactor: CGFloat = 1.2 // Adjust this value to make the circular mask larger
        let diameter = min(bounds.width, bounds.height) * scaleFactor
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - diameter / 2, y: bounds.midY - diameter / 2, width: diameter, height: diameter)).cgPath
        layer.mask = mask
    }
}







