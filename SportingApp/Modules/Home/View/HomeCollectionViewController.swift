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
    @IBOutlet weak var noconnection: UIView!
    
    var reachability: Reachability?

    var homeViewModel:HomeViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
//   let layout = UICollectionViewFlowLayout()
//   collectionView.minimumLineSpacing = 0
//   collectionView.collectionViewLayout = layout
        homeViewModel = HomeViewModel()
//        homeViewModel?.fetchLeaguesViewModel(for: "football")
        do {
                     reachability = try Reachability()
                 } catch {
                     print("Unable to create Reachability")
                 }
                 
                  NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)

                 do {
                     try reachability?.startNotifier()
                   

                 } catch {
                     print("Unable to start Reachability notifier")
                 }
               ///
        homeViewModel?.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                print(self?.homeViewModel?.LeagueResultVar as? [League])
                self?.collectionView!.reloadData()
            }
            
        }

    }

    @objc func reachabilityChanged(_ notification: Notification) {
          guard let reachability = notification.object as? Reachability else { return }
          
          if reachability.connection != .unavailable {
              noconnection.isHidden = true
            print("Network is available")

          } else {
            noconnection.isHidden = false
            print("Network is unavailable")
          }
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
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let selectedSport = homeViewModel?.getSports()[indexPath.item]
        print(selectedSport)
        homeViewModel?.sport_name = selectedSport?.name
        homeViewModel?.fetchLeaguesViewModel(for: selectedSport!.name)
        let LeaguePage = storyBoard.instantiateViewController(withIdentifier: "LeaguePage") as! LeagueTableViewController
        LeaguePage.nameSport = selectedSport!.name
        self.navigationController?.pushViewController(LeaguePage, animated: true)
        }
    

 func collectionView(
         _ collectionView: UICollectionView,
         layout collectionViewLayout: UICollectionViewLayout,
         minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat { return 0.0 }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {return 0.0 }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
 
}
