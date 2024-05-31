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
//        imgLeague.layer.cornerRadius = imgLeague.frame.size.width/2
//        imgLeague.layer.masksToBounds = true
         imgLeague.layer.cornerRadius = imgLeague.frame.width / 2
        //    imgLeague.masksToBounds =
            imgLeague.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    override func layoutSubviews() {
        super.layoutSubviews()
        //imgLeague.layer.borderWidth = 2.0
        //imgLeague.layer.borderColor = UIColor.black.cgColor
       // imgLeague.round()
        imgLeague.layer.cornerRadius = imgLeague.frame.width / 2
    //    imgLeague.masksToBounds =
        imgLeague.clipsToBounds = true
        
        
        
        
        

    }

}
//extension UIView {
//    func round() {
//        let scaleFactor: CGFloat = 2.6 // Adjust this value to make the circular mask larger
//        let diameter = min(bounds.width, bounds.height) * scaleFactor
//        let mask = CAShapeLayer()
//        mask.path = UIBezierPath(ovalIn: CGRect(x: bounds.midX - diameter / 2, y: bounds.midY - diameter / 2, width: diameter, height: diameter)).cgPath
//        layer.mask = mask
//    }
//}
//extension UIView {
//    func round() {
//        // Calculate the smaller dimension (width or height) to ensure the circular mask fits inside the bounds
//        let smallerDimension = min(bounds.width, bounds.height)
//
//        // Adjust this value to control the size of the circular mask relative to the view's bounds
//        let scaleFactor: CGFloat = 0.6
//
//        // Calculate the diameter of the circular mask
//        let diameter = smallerDimension * scaleFactor
//
//        // Calculate the origin of the oval frame to center it within the view's bounds
//        let ovalOriginX = (bounds.width - diameter) / 2
//        let ovalOriginY = (bounds.height - diameter) / 2
//
//        // Create the circular mask
//        let mask = CAShapeLayer()
//        mask.path = UIBezierPath(ovalIn: CGRect(x: ovalOriginX, y: ovalOriginY, width: diameter, height: diameter)).cgPath
//
//        // Apply the mask to the view's layer
//        layer.mask = mask
//
//        // Create a border around the circular mask
//        let borderLayer = CAShapeLayer()
//        borderLayer.path = mask.path // Reuse the circular mask path
//        borderLayer.lineWidth = 2.0 // Adjust the border width as needed
//        borderLayer.strokeColor = UIColor.black.cgColor // Set the border color to black
//        borderLayer.fillColor = UIColor.clear.cgColor // Make the border transparent
//
//        // Add the border layer to the view's layer
//        layer.addSublayer(borderLayer)
//    }
//}
//
//


extension UIView {
    func round() {
        // Calculate the smaller dimension (width or height) to ensure the circular mask fits inside the bounds
        let smallerDimension = min(bounds.width, bounds.height)
        
        // Adjust this value to control the size of the circular mask relative to the view's bounds
        let scaleFactor: CGFloat = 1.1 // Increase this value to make the circular mask larger
        
        // Calculate the diameter of the circular mask
        let diameter = smallerDimension * scaleFactor
        
        // Calculate the origin of the oval frame to center it within the view's bounds
        let ovalOriginX = (bounds.width - diameter) / 2
        let ovalOriginY = (bounds.height - diameter) / 2
        
        // Create the circular mask
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalIn: CGRect(x: ovalOriginX, y: ovalOriginY, width: diameter, height: diameter)).cgPath
        
        // Apply the mask to the view's layer
        layer.mask = mask
        
        // Create a border around the circular mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the circular mask path
       // borderLayer.lineWidth = 1.0 // Adjust the border width as needed
        borderLayer.strokeColor = UIColor.black.cgColor // Set the border color to black
        borderLayer.fillColor = UIColor.clear.cgColor // Make the border transparent
        
        // Add the border layer to the view's layer
        layer.addSublayer(borderLayer)
    }
}
