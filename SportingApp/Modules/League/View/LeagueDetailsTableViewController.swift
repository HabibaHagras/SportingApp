//
//  LeagueDetailsTableViewController.swift
//  SportingApp
//
//  Created by maha on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import Reachability
import SDWebImage

class LeagueDetailsTableViewController: UITableViewController,UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var eventsCollection: UICollectionView!
       //var reachability: Reachability?
        var eventsViewModel:EventsViewModle?
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsViewModel =  EventsViewModle()
       let nib = UINib(nibName: "CustomEventCell", bundle: nil)
        eventsCollection.register(nib, forCellWithReuseIdentifier: "cell")
       eventsCollection.delegate = self
          eventsCollection.dataSource = self
        
     
        eventsViewModel?.fetchUpcomingEvents()
        //   print(self?.homeViewModel?.LeagueResultVar as? [League])
        
            
            // Bind result updates to reload collection view
            eventsViewModel?.bindResultToViewController = { [weak self] in
                DispatchQueue.main.async {
                    self?.eventsCollection.reloadData()
//
//                    print("cccccccccccccccccc\(self?.eventsViewModel?.eventResult?[0])")
//                    print("controler")
                }
            }
       
    }




    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
     wikimedia
//
//        cell.imageCell.sd_setImage(with: URL(string: eventsViewModel?.eventResult?[0].eventHomeTeamLogo ?? "1.jpeg"), placeholderImage: UIImage(named: "1.jpeg"))
        if let event = self.eventsViewModel?.eventResult?[0] {
                   cell.imageCell.sd_setImage(with: URL(string: event.eventHomeTeamLogo ?? "https://upload..org/wikipedia/commons/thumb/f/f0/Error.svg/1200px-Error.svg.png"), placeholderImage: UIImage(named: "1.jpeg"))
               }
        
        return cell
    }*/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        
        if let event = eventsViewModel?.eventResult?[indexPath.item] {
            cell.dateLB.text = event.eventDate
             cell.timeLB.text = event.eventTime
             cell.homeTeamLB.text = event.eventHomeTeam
            cell.awayTeamLB.text = event.eventAwayTeam
            if let urlString = event.homeTeamLogo, let url = URL(string: urlString) {
                cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               

            
            } else {
                cell.imageCell.image = UIImage(named: "1.jpeg")
            }
            if let urlString = event.awayTeamLogo, let url = URL(string: urlString) {
                 cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                
            
        } else {
            cell.imageCell.image = UIImage(named: "1.jpeg")
        }
        }
        
        return cell
    }


   func numberOfSections(in collectionView: UICollectionView) -> Int {
          // #warning Incomplete implementation, return the number of sections
          return 1
      }
   

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of items
          return eventsViewModel?.eventResult?.count ?? 0
    }
/*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate cell size based on content or device screen size
        
        // Get the height of the collection view
        let collectionViewHeight = collectionView.bounds.height
        
        // Calculate the desired cell height (you can adjust this as needed)
        let cellHeight = collectionViewHeight - 20 // For example, 20 points spacing from top and bottom
        
        // Calculate the aspect ratio of your image (assuming it's a square image)
        let imageAspectRatio: CGFloat = 1.0 // Adjust this based on your actual image aspect ratio
        
        // Calculate the cell width based on the aspect ratio and desired height
        let cellWidth = cellHeight * imageAspectRatio
        
        // Return the calculated size
        return CGSize(width: cellWidth, height: cellHeight)
    }
 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set your desired cell width and height here
        let cellWidth = collectionView.frame.width  // Example: half the width of the collection view minus some spacing
        let cellHeight: CGFloat = 150 // Example: fixed height of 150 points
        return CGSize(width: cellWidth, height: cellHeight)
    }

}
