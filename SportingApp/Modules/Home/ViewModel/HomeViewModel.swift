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
    var bindNetworkStatusToViewController: (() -> ())?
    var leagueResponseVar: LeagueResponse?
    var LeagueResultVar : [League]? = []
    var videoResponseVar: VideoResponse?
    var videoResultVar : [Video]? = []
    var sport_name :String!
    var bindResultToViewController :(()->()) = {}
    var bindResultNetworkToViewController :(()->()) = {}
    var bindResultNetworkVideosToViewController :(()->()) = {}
    var isNetworkAvailable: Bool = true {
          didSet {
              bindNetworkStatusToViewController?()
          }
      }
    
     func fetchLeaguesViewModel(for sport: String) {
        NetworkServices.fetchLeagues(for: sport) { [weak self] league in
                   self?.leagueResponseVar = league
        self?.LeagueResultVar = league?.result
                self?.bindResultToViewController() 

    }
    
}
    
    
      func fetchVideoViewModel(for sport: String) {
            NetworkServices.fetchVideos(for: sport) { [weak self] video in
                       self?.videoResponseVar = video
            self?.videoResultVar = video?.result
                    self?.bindResultNetworkVideosToViewController()

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
    
    init() {
        setupReachability()
    }

    private func setupReachability() {
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to create Reachability")
            return
        }

        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)

        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start Reachability notifier")
        }

        checkNetwork()
    }

    @objc private func reachabilityChanged(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else { return }
        isNetworkAvailable = reachability.connection != .unavailable
    }

    func checkNetwork() {
        isNetworkAvailable = reachability?.connection != .unavailable
    }



}
