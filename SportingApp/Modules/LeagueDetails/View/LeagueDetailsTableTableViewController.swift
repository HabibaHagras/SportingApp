//
//  LeagueDetailsTableTableViewController.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//
import UIKit
import Reachability
import SDWebImage

class LeagueDetailsTableViewController: UITableViewController,UICollectionViewDataSource ,UICollectionViewDelegate{
    @IBOutlet weak var resultsCollectionView: UICollectionView!

    @IBOutlet weak var eventsCollection: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    //var reachability: Reachability?
        var eventsViewModel:EventsViewModle?
    /*
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
 */
    override func viewDidLoad() {
           super.viewDidLoad()
           eventsViewModel = EventsViewModle()
        Utlies.dateForCurrentEvents()
        Utlies.dateForLatestResEvents()
       print("past time\(Utlies.pastTime)")
        print("current time\(Utlies.myCurrentTime)")
           
           let nib = UINib(nibName: "CustomEventCell", bundle: nil)
        let teamNib = UINib(nibName: "CustomTeamsCell", bundle: nil)
           eventsCollection.register(nib, forCellWithReuseIdentifier: "cell")
           resultsCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        teamsCollectionView.register(teamNib, forCellWithReuseIdentifier: "cell")
           //let resultNib = UINib(nibName: "CustomEventCell", bundle: nil)
           //resultsCollectionView.register(resultNib, forCellWithReuseIdentifier: "/*")
           eventsCollection.delegate = self
           eventsCollection.dataSource = self
           resultsCollectionView.delegate = self
           resultsCollectionView.dataSource = self
        teamsCollectionView.dataSource = self
        teamsCollectionView.delegate = self
           
           eventsViewModel?.fetchUpcomingEvents()
        eventsViewModel?.fetchLatestResults()
        eventsViewModel?.fetchTeams()
           
           eventsViewModel?.bindResultToViewController = { [weak self] in
               DispatchQueue.main.async {
                   self?.eventsCollection.reloadData()
                   self?.resultsCollectionView.reloadData()
                self?.teamsCollectionView.reloadData()
               }
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return eventsViewModel?.eventResult?.count ?? 0
       }
       
       /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
                   cell.awayImage.image = UIImage(named: "1.jpeg")
               }
           }
           
           return cell
       }*/
    
    /* eroor
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
            
            if let event = eventsViewModel?.eventResult?[indexPath.item] {
                cell.dateLB.text = event.eventDate
                cell.timeLB.text = event.eventTime
                cell.homeTeamLB.text = event.eventHomeTeam
                cell.awayTeamLB.text = event.eventAwayTeam
                cell.resultLb.text = ""
                
                if let urlString = event.homeTeamLogo, let url = URL(string: urlString) {
                    cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                } else {
                    cell.imageCell.image = UIImage(named: "1.jpeg")
                }
                
                if let urlString = event.awayTeamLogo, let url = URL(string: urlString) {
                    cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                } else {
                    cell.awayImage.image = UIImage(named: "1.jpeg")
                }
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! CustomCollectionViewCell
            
            if let result = eventsViewModel?.eventResult?[indexPath.item] {
                // Configure the result cell with data
//                cell.dateLabel.text = result.eventDate
//                cell.scoreLabel.text = "\(result.homeTeamScore) - \(result.awayTeamScore)"
//                cell.homeTeamLabel.text = result.eventHomeTeam
//                cell.awayTeamLabel.text = result.eventAwayTeam
                
          if let urlString = result.homeTeamLogo, let url = URL(string: urlString) {
                        cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                    } else {
                        cell.imageCell.image = UIImage(named: "1.jpeg")
                    }
                    
                    if let urlString = result.awayTeamLogo, let url = URL(string: urlString) {
                        cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
                    } else {
                        cell.awayImage.image = UIImage(named: "1.jpeg")
                    }
                }
            
            return cell
        }
    }*/
    
    /* correct
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == eventsCollection || collectionView == resultsCollectionView{
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
                cell.awayImage.image = UIImage(named: "1.jpeg")
            }
            
            if collectionView == resultsCollectionView {
                cell.resultLb.text = event.eventFinalResult
            } else {
                cell.resultLb.text = ""
            }
        }
        
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTeamsCell
            
           // if let team = eventsViewModel?.eventResult?[indexPath.item] {
              //  cell.teamNameLB.text = "maha"
            
        //}
        
    
        return cell
    }
    }*/
    
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        if collectionView == teamsCollectionView {
             
            return CGSize(width:100, height: 100)
        }

               let cellHeight: CGFloat = 150
               return CGSize(width: cellWidth, height: cellHeight)
      
    }

       
       override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
      //  return 300
        if indexPath.section == 0 {
               // Change this value to the desired height for the first section
               return 50
        } else if  indexPath.section == 2 {
            return 150
        } else  {
               // Change this value to the desired height for the second section
               return 300
           }
       }
 
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if collectionView == eventsCollection {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
           if let event = eventsViewModel?.eventResult, indexPath.item < event.count {
               let eventItem = event[indexPath.item]
               cell.dateLB.text = eventItem.eventDate
               cell.timeLB.text = eventItem.eventTime
               cell.homeTeamLB.text = eventItem.eventHomeTeam
               cell.awayTeamLB.text = eventItem.eventAwayTeam
               if let urlString = eventItem.homeTeamLogo, let url = URL(string: urlString) {
                   cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               } else {
                   cell.imageCell.image = UIImage(named: "1.jpeg")
               }
               if let urlString = eventItem.awayTeamLogo, let url = URL(string: urlString) {
                   cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               } else {
                   cell.awayImage.image = UIImage(named: "1.jpeg")
               }
               cell.resultLb.text = ""
           }
           return cell
       } else if collectionView == resultsCollectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
           if let event = eventsViewModel?.latestResults, indexPath.item < event.count {
               let eventItem = event[indexPath.item]
               cell.dateLB.text = eventItem.eventDate
               cell.timeLB.text = eventItem.eventTime
               cell.homeTeamLB.text = eventItem.eventHomeTeam
               cell.awayTeamLB.text = eventItem.eventAwayTeam
               if let urlString = eventItem.homeTeamLogo, let url = URL(string: urlString) {
                   cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               } else {
                   cell.imageCell.image = UIImage(named: "1.jpeg")
               }
               if let urlString = eventItem.awayTeamLogo, let url = URL(string: urlString) {
                   cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
               } else {
                   cell.awayImage.image = UIImage(named: "1.jpeg")
               }
               cell.resultLb.text = eventItem.eventFinalResult
           }
           return cell
       } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTeamsCell
           // Set up your cell for teams collection view
       if let event = eventsViewModel?.legueTeams, indexPath.item < event.count {
       let eventItem = event[indexPath.item]
        if let urlString = eventItem.teamLogo, let url = URL(string: urlString) {
            cell.teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "1.jpeg"))
        } else {
            cell.teamImage.image = UIImage(named: "1.jpeg")
        }
        
        }
           return cell
       }
   }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == teamsCollectionView {
//            // Ensure the storyboard identifier is correct
//            if let viewController = storyboard?.instantiateViewController(withIdentifier: "TeamsDetails") as? TeamDetailsViewController {
//                
//                if let team = eventsViewModel?.legueTeams?[indexPath.item] {
//                    viewController.team = team
//                }
//         
//                 viewController.modalPresentationStyle = .fullScreen
//                present(viewController, animated: true, completion: nil)
//            } else {
//                print("Could not instantiate view controller with identifier 'TeamsDetails'")
//            }
//        }
//    }

  
     
}