//
//  TeamDetailsViewController.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class TeamDetailsViewController: UIViewController,UICollectionViewDataSource ,UICollectionViewDelegate {
   
    
     //var team: Team?
     var viewModel: TeamDetailsViewModel?
        @IBOutlet weak var teamImage: UIImageView!
        
        @IBOutlet weak var teamNameLB: UILabel!
        
        @IBOutlet weak var playersCollectionView: UICollectionView!
        override func viewDidLoad() {
            playersCollectionView.delegate = self
                  playersCollectionView.dataSource = self
            super.viewDidLoad()
//            teamNameLB.text = team?.teamName
//            if let imageUrl = team?.teamLogo, let url = URL(string: imageUrl) {
//                       teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
//                   } else {
//                       teamImage.image = UIImage(named: "team")
//                   }
       updateUI()
           
        }
    private func updateUI() {
        if let team = viewModel?.team {
            teamNameLB.text = team.teamName
            if let urlString = team.teamLogo, let url = URL(string: urlString) {
                teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
            } else {
                teamImage.image = UIImage(named: "team")
            }
            if let players = viewModel?.team?.players {
                       for player in players {
                           print("Player Name: \(player.playerName)")
                           // Add more properties if needed
                       }
                   } else {
                       print("No players found")
                   }
            playersCollectionView.reloadData()
        }
          
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.team?.players?.count ?? 0
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
              return 5// Adjust spacing as needed
          }
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Configure the cell
        //if let player = team?.players[indexPath.item] {
            let playerNameLabel = cell.viewWithTag(1) as? UILabel
            let playerImageView = cell.viewWithTag(2) as? UIImageView
            
//
        // }  playerNameLabel?.text = team?.teamName
        //        if let imageUrl = team?.teamLogo, let url = URL(string: imageUrl) {
        //                playerImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.jpeg"))
        //            } else {
        //                playerImageView?.image = UIImage(named: "placeholder.jpeg")
        //            }
 
//        if let player = team?.players?[indexPath.item] {
//            let playerNameLabel = cell.viewWithTag(1) as? UILabel
//            let playerImageView = cell.viewWithTag(2) as? UIImageView
//
//            playerNameLabel?.text = player.playerName
//            if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
//                playerImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
//            } else {
//                playerImageView?.image = UIImage(named: "team")
//            }
//        }
        
        return cell
    }
 */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//        if let player = viewModel?.team?.players?[indexPath.item] {
//               let playerNameLabel = cell.viewWithTag(1) as? UILabel
//               let playerImageView = cell.viewWithTag(2) as? UIImageView
//
//            playerNameLabel?.text = player.playerName
//               if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
//                   playerImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
//               } else {
//                   playerImageView?.image = UIImage(named: "team")
//               }
//           }
//
//           return cell
//       }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                  
               if let player = viewModel?.team?.players?[indexPath.item] {
                      let playerNameLabel = cell.viewWithTag(2) as? UILabel
                      let playerImageView = cell.viewWithTag(1) as? UIImageView
                      
                   playerNameLabel?.text = player.playerName
                      if let imageUrl = player.playerImage, let url = URL(string: imageUrl) {
                          playerImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "player"))
                      } else {
                          playerImageView?.image = UIImage(named: "player")
                      }
                
                      if let playerImageView = playerImageView {
                          playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
                          playerImageView.clipsToBounds = true
                      }
                  }
                  
                  return cell
    }
    
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
}

    
