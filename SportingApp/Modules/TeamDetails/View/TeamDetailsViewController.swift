//
//  TeamDetailsViewController.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController {
     var team: Team?
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamNameLB: UILabel!
    
    @IBOutlet weak var playersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamNameLB.text = team?.teamName
        if let imageUrl = team?.teamLogo, let url = URL(string: imageUrl) {
                   teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               } else {
                   teamImage.image = UIImage(named: "1.jpeg")
               }
   
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
