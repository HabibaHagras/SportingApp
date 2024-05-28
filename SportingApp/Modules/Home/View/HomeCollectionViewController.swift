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
    //var reachability: Reachability?
    var networkCheckTimer: Timer?
    @IBOutlet weak var noconnection: UIView!
    var noConnectionView: UIView!
    let reachability = try! Reachability()
    var homeViewModel:HomeViewModel?
    var conntictions: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(CustomHeaderVieww.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView")

         if reachability.connection == .unavailable {
                print("viewDidLoadUnnnnnnnnnnnnnNetWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
                     self.present(showAlert(), animated: true)
            conntictions = false

                }
        homeViewModel = HomeViewModel()
        self.noconnection.isHidden = true
        homeViewModel?.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
//                print(self?.homeViewModel?.LeagueResultVar as? [League])
              

                self?.collectionView!.reloadData()
            }
    
        }

    }
 
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if reachability.connection == .unavailable {
            print("viewWillAppearUnnnnnnnnnnnnnNetWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
            conntictions = false
             self.present(showAlert(), animated: true)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
            if reachability.connection == .unavailable {
                print("viewDidAppearUnnnnnnnnnnnnnNetWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
                conntictions = false

                 self.present(showAlert(), animated: true)
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: 60) //
     }
   
     override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if kind == UICollectionView.elementKindSectionHeader {
              guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomHeaderView", for: indexPath) as? CustomHeaderVieww else {
                  fatalError("Cannot create header view")
              }
              //headerView.titleLabel.text = "Wellcom Home" // Set your header title
              return headerView
          }
          return UICollectionReusableView()
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
             cell.cellLabel.text = sport.nameHome
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
    ) -> CGFloat { return 8.9 }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {return 0.9 }
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 16, bottom: 3, right: 16)
//    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        // Calculate the width of the screen
        let screenWidth = UIScreen.main.bounds.width

        // Calculate the total desired horizontal inset (left + right)
        // Adjust this value as needed to achieve the desired look
        let totalHorizontalInset: CGFloat = 32

        // Calculate the individual left and right insets
        let horizontalInset = (screenWidth - collectionView.frame.width + totalHorizontalInset) / 2

        // Return the insets with dynamic left and right values
        return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 3, right: horizontalInset)
    }

 
}
