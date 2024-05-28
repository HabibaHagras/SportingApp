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
    var idinticator: UIActivityIndicatorView?
    var isInFavorites: Bool = false
    @IBOutlet weak var resultsCollectionView: UICollectionView!

    @IBOutlet weak var addFavBtn: UIButton!
    @IBOutlet weak var eventsCollection: UICollectionView!
    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    //var reachability: Reachability?
    var leagueDetailsViewModle: LeagueDetailsViewModle?
    var favViewModel: FavoriteViewModel?
    var nameSport :String?
    var leagueId :Int!
    var leagueName  :String!
    var leagueLogo:String!


    override func viewDidLoad() {
           super.viewDidLoad()
        idinticator = UIActivityIndicatorView(style: .large)
        idinticator!.center = view.center
        idinticator!.startAnimating()
        view.addSubview(idinticator!)
           //eventsViewModel = EventsViewModle()
        let coreDataServices = DependencyInjector.shared.resolveCoreDataServices()
        leagueDetailsViewModle = LeagueDetailsViewModle(coreDataServices: coreDataServices)
        favViewModel = FavoriteViewModel(coreDataServices: coreDataServices)
        leagueDetailsViewModle?.sportName = nameSport
        leagueDetailsViewModle?.leagueId = leagueId
        leagueDetailsViewModle?.leagueName = leagueName
        leagueDetailsViewModle?.leagueLogo = leagueLogo
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
   
           
//           eventsViewModel?.fetchUpcomingEvents()
//        eventsViewModel?.fetchLatestResults()
//        eventsViewModel?.fetchTeams()
        DispatchQueue.global().async {
            self.leagueDetailsViewModle?.fetchUpcomingEvents()
            self.leagueDetailsViewModle?.fetchLatestResults()
            self.leagueDetailsViewModle?.fetchTeams()
        }
           leagueDetailsViewModle?.bindResultToViewController = { [weak self] in
             
               DispatchQueue.main.async {

                   self?.eventsCollection.reloadData()
                   self?.resultsCollectionView.reloadData()
                self?.teamsCollectionView.reloadData()
                 self?.idinticator?.stopAnimating()

               }
           }
        isInFavorites = (leagueDetailsViewModle?.isLeagueSavedToCoreData(leagueId: leagueId))!
        
        udateFvoriteButton()
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return leagueDetailsViewModle?.eventResult?.count ?? 0
       }
       
     
    
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
        } else if  indexPath.section == 1 {
            return 250
         } else if  indexPath.section == 2 {
                   return 150
               }else  {
               // Change this value to the desired height for the second section
               return 300
           }
       }
 
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if collectionView == eventsCollection {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
           if let event = leagueDetailsViewModle?.eventResult, indexPath.item < event.count {
               let eventItem = event[indexPath.item]
               cell.dateLB.text = eventItem.eventDate
               cell.timeLB.text = eventItem.eventTime
               cell.homeTeamLB.text = eventItem.eventHomeTeam
               cell.awayTeamLB.text = eventItem.eventAwayTeam
               if let urlString = eventItem.homeTeamLogo, let url = URL(string: urlString) {
                   cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
               } else {
                   cell.imageCell.image = UIImage(named: "team")
               }
               if let urlString = eventItem.awayTeamLogo, let url = URL(string: urlString) {
                   cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
               } else {
                   cell.awayImage.image = UIImage(named: "team")
               }
               cell.resultLb.text = ""
           }
           return cell
       } else if collectionView == resultsCollectionView {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
           if let event = leagueDetailsViewModle?.latestResults, indexPath.item < event.count {
               let eventItem = event[indexPath.item]
               cell.dateLB.text = eventItem.eventDate
               cell.timeLB.text = eventItem.eventTime
               cell.homeTeamLB.text = eventItem.eventHomeTeam
               cell.awayTeamLB.text = eventItem.eventAwayTeam
               if let urlString = eventItem.homeTeamLogo, let url = URL(string: urlString) {
                   cell.imageCell.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
               } else {
                   cell.imageCell.image = UIImage(named: "team")
               }
               if let urlString = eventItem.awayTeamLogo, let url = URL(string: urlString) {
                   cell.awayImage.sd_setImage(with: url, placeholderImage: UIImage(named: "team"))
               } else {
                   cell.awayImage.image = UIImage(named: "team")
               }
               cell.resultLb.text = eventItem.eventFinalResult
           }
           return cell
       } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTeamsCell
           // Set up your cell for teams collection view
       if let event = leagueDetailsViewModle?.legueTeams, indexPath.item < event.count {
       let eventItem = event[indexPath.item]
        if let urlString = eventItem.teamLogo, let url = URL(string: urlString) {
            cell.teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "hands"))
        } else {
            cell.teamImage.image = UIImage(named: "hands")
        }
        
        }
           return cell
       }
   }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionView {
            
            if let viewController = storyboard?.instantiateViewController(withIdentifier: "TeamsDetails") as? TeamDetailsViewController {

                if let team = leagueDetailsViewModle?.legueTeams?[indexPath.item] {
                   // viewController.team = team
                    let teamDetailsViewModel = TeamDetailsViewModel(team: team)
               viewController.viewModel = teamDetailsViewModel
                }

                 viewController.modalPresentationStyle = .fullScreen
                present(viewController, animated: true, completion: nil)
            } else {
                print("Could not instantiate view controller with identifier 'TeamsDetails'")
            }
        }
    }

  
    @IBAction func backBtn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favBtn(_ sender: Any) {
       isInFavorites.toggle()
        udateFvoriteButton()
        if (isInFavorites){
             addFavBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        if let leagueId = leagueId, let leagueName = leagueDetailsViewModle?.eventResult?.first?.leagueName, let logo =  leagueDetailsViewModle?.eventResult?.first?.leagueLogo, let sportName = nameSport {
            leagueDetailsViewModle?.saveLeague(id: leagueId, name: leagueName, logo: logo, sport: sportName)
            }
            
        }else{
            addFavBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            leagueDetailsViewModle?.removeLeagueFromCoreData(leagueId: leagueId)
        }
        
    }
    func udateFvoriteButton()
       {
           if isInFavorites {
               addFavBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
           }else{
                  addFavBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            
           }
       }
    
 
    
}
