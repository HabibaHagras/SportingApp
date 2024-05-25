//
//  HomeViewModel.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import Reachability
class HomeViewModel {
    var reachability: Reachability?
    var leagueResponseVar: LeagueResponse?
    var LeagueResultVar : [League]? = []
    var sport_name :String!
    var bindResultToViewController :(()->()) = {}
    var bindResultNetworkToViewController :(()->()) = {}

    
     func fetchLeaguesViewModel(for sport: String) {
        NetworkServices.fetchLeagues(for: sport) { [weak self] league in
                   self?.leagueResponseVar = league
        self?.LeagueResultVar = league?.result
                self?.bindResultToViewController() 

    }
    
}
    
    func getSports() -> [Sport] {
          return [
              Sport(name: "football", imageName: "fooot"),
              Sport(name: "basketball", imageName: "basketball_image"),
              Sport(name: "cricket", imageName: "cricket_image"),
              Sport(name: "tennis", imageName: "tennis_image"),
//              Sport(name: "baseball", imageName: "baseball_image"),
//              Sport(name: "american Football", imageName: "american_football_image")
          ]
      }
    
    func checkNetwork() {
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
    }
    
    @objc func reachabilityChanged(_ notification: Notification) {
          guard let reachability = notification.object as? Reachability else { return }
          
          if reachability.connection != .unavailable {
            self.bindResultToViewController()
            }

     else {
              print("Network is unavailable")
          }
      }


}
