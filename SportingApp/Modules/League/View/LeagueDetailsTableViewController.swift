//
//  LeagueDetailsTableViewController.swift
//  SportingApp
//
//  Created by maha on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit

class LeagueDetailsTableViewController: UITableViewController,UICollectionViewDataSource ,UICollectionViewDelegate {
    @IBOutlet weak var eventsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       let nib = UINib(nibName: "CustomEventCell", bundle: nil)
        eventsCollection.register(nib, forCellWithReuseIdentifier: "cell")
       eventsCollection.delegate = self
          eventsCollection.dataSource = self
        
       
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        // Configure the cell...
      
        cell.imageCell.image = UIImage(named: "1.jpeg")
        return cell
    }


   func numberOfSections(in collectionView: UICollectionView) -> Int {
          // #warning Incomplete implementation, return the number of sections
          return 1
      }
   

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of items
          return 15
    }

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
}
