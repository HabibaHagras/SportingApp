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
       do {
                  reachability = try Reachability()
              } catch {
                  print("Unable to create Reachability")
              }

              // Start observing reachability changes
              NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
              do {
                try reachability?.startNotifier()
              } catch {
                  print("Unable to start Reachability notifier")
              }
        homeViewModel?.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                print(self?.homeViewModel?.LeagueResultVar as? [League])
              

                self?.collectionView!.reloadData()
            }
    
        }
        
        self.updateNetworkStatusUI()
                   
                   // Start periodic network status check
                   startNetworkCheckTimer()
     // Start periodic network status check

//        homeViewModel?.bindNetworkStatusToViewController = { [weak self] in
//                   DispatchQueue.main.async {
//
//                       let isNetworkAvailable = self?.homeViewModel?.isNetworkAvailable ?? false
//                       self?.noconnection.isHidden = isNetworkAvailable
//                       self?.collectionView.isHidden = !isNetworkAvailable
//                    if !isNetworkAvailable {
//                        let alertController = UIAlertController(title: "No Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
//                             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                             alertController.addAction(okAction)
//                        self?.present(alertController, animated: true, completion: nil)
//                        }
//                   }
//               }
      //      self.homeViewModel?.checkNetwork()

    }
    
    func startNetworkCheckTimer() {
        networkCheckTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.updateNetworkStatusUI()
        }
    }
    
    // Stop periodic network status check
    func stopNetworkCheckTimer() {
        networkCheckTimer?.invalidate()
        networkCheckTimer = nil
    }
  @objc func reachabilityChanged(_ notification: Notification) {
    guard (notification.object as? Reachability) != nil else { return }
        updateNetworkStatusUI()
    }
    
    // Update UI based on network status
    func updateNetworkStatusUI() {
        if reachability?.connection != .unavailable {
            print("Network is available")
            noconnection.isHidden = true
            collectionView.reloadData() // Reload collection view to hide cells
        } else {
            print("Network is unavailable")
            noconnection.isHidden = false
            collectionView.reloadData() // Reload collection view to hide cells
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
        self.homeViewModel?.checkNetwork()
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
