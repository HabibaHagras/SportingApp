//
//  HomeCollectionViewController.swift
//  SportingApp
//
//  Created by habiba on 5/16/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import UIKit
import Reachability


class HomeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var reachability: Reachability?
    var networkCheckTimer: Timer?
    @IBOutlet weak var noconnection: UIView!
    var noConnectionView: UIView!

    var homeViewModel:HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel = HomeViewModel()
 
        homeViewModel?.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                print(self?.homeViewModel?.LeagueResultVar as? [League])
              

                self?.collectionView!.reloadData()
            }
    
        }

    }
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
        return CGSize(width: view.frame.width / 2.2, height: view.frame.width / 1.4)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return homeViewModel?.getSports().count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
    if let sport = homeViewModel?.getSports()[indexPath.item] {
             cell.cellLabel.text = sport.name
             cell.cellImg.image = UIImage(named: sport.imageName)
         }

      
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let reachability = try! Reachability()
         if reachability.connection != .unavailable {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let selectedSport = homeViewModel?.getSports()[indexPath.item]
        print(selectedSport)
        homeViewModel?.sport_name = selectedSport?.name
        homeViewModel?.fetchLeaguesViewModel(for: selectedSport!.name)
        let LeaguePage = storyBoard.instantiateViewController(withIdentifier: "LeaguePage") as! LeagueTableViewController
        LeaguePage.nameSport = selectedSport!.name
        self.navigationController?.pushViewController(LeaguePage, animated: true)
            } else {
                       self.present(showAlert(), animated: true)
                   }
        }
    
    func showAlert() -> UIAlertController{
           let alert = UIAlertController(title: "Error!", message: "please check your connection and try again later", preferredStyle: UIAlertController.Style.alert)

           alert.addAction(UIAlertAction(title: "OK",style: UIAlertAction.Style.default,handler:nil))
           return alert
       }
 func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { return 10.9 }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {return 4.9 }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 3, right: 16)
    }
    
 
}
