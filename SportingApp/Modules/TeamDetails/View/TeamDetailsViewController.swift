//
//  TeamDetailsViewController.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate {
   
    
     var team: Team?
        @IBOutlet weak var teamImage: UIImageView!
        
        @IBOutlet weak var teamNameLB: UILabel!
        
        @IBOutlet weak var playersCollectionView: UICollectionView!
        override func viewDidLoad() {
            playersCollectionView.delegate = self
                  playersCollectionView.dataSource = self
            super.viewDidLoad()
            teamNameLB.text = team?.teamName
            if let imageUrl = team?.teamLogo, let url = URL(string: imageUrl) {
                       teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                   } else {
                       teamImage.image = UIImage(named: "1.jpeg")
                   }
       
           
        }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 10
       }
       
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                 let collectionViewWidth = collectionView.bounds.width
                 let totalSpacing: CGFloat = 100
                 let itemWidth = (collectionViewWidth - totalSpacing) / 2
                 return CGSize(width: itemWidth, height: itemWidth) // 
             }
//
//          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//              let collectionViewWidth = collectionView.bounds.width
//              let itemWidth = (collectionViewWidth - 20) / 2
//              return CGSize(width: itemWidth, height: itemWidth) // A
//          }
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
              return 10 // Adjust spacing as needed
          }
          
          func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
              return 10 // Adjust spacing as needed
          }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Configure the cell
        //if let player = team?.players[indexPath.item] {
            let playerNameLabel = cell.viewWithTag(1) as? UILabel
            let playerImageView = cell.viewWithTag(2) as? UIImageView
            
            playerNameLabel?.text = team?.teamName
        if let imageUrl = team?.teamLogo, let url = URL(string: imageUrl) {
                playerImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.jpeg"))
            } else {
                playerImageView?.image = UIImage(named: "placeholder.jpeg")
            }
       // }
        
        return cell
    }
    
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
}

    
