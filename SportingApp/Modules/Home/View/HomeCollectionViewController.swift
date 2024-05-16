//
//  HomeCollectionViewController.swift
//  SportingApp
//
//  Created by habiba on 5/16/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit


class HomeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
     let sports = ["Football", "Basketball", "Cricket", "Hockey", "Baseball", "American Football"
]
    let imageNames: [String: String] = [
        "Football": "football_image",
        "Basketball": "basketball_image",
        "Cricket": "cricket_image",
        "Hockey": "hockey_image",
        "Baseball": "baseball_image",
        "American Football": "american_football_image"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
   let layout = UICollectionViewFlowLayout()
   layout.minimumLineSpacing = 0 // Set the minimum line spacing to zero to remove space between rows
   collectionView.collectionViewLayout = layout

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destin/Users/habiba/Documents/SportingApp/SportingApp/SportingApp/Modules/Home/View/HomeCollectionViewCell.swiftationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: view.frame.width / 2.2, height: view.frame.width / 1.4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Set the minimum interitem spacing to zero to remove the space between cells
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
    
        cell.cellLabel.text = sports[indexPath.item]
        if let imageName = imageNames[sports[indexPath.item]] {
               cell.cellImg.image = UIImage(named: imageName)
           }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
