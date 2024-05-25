//
//  EventsViewModle.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
class EventsViewModle{
     var eventResponse: EventsResponse?
    var teamsResponse: Teams?
        var eventResult: [Event]? = []
        var latestResults: [Event]? = []
    var legueTeams: [Team]? = []
    var sportName: String?
    var leagueId :Int!
    
        var bindResultToViewController :(()->()) = {}

        
         func fetchUpcomingEvents() {
            print("----------------------------------")
            print(sportName!)
            print("----------------------------------")
            print("----------------------------------")
            print("----------------------------------")
                let url = "\(Constants.bseUrl)\(sportName!)?met=Fixtures&leagueId=\(leagueId!)&from=\(Utlies.currentTime!)&to=\(Utlies.futureTime!)&APIkey=\(Constants.apiKey)"
            print("after fetch")
            fetchData(url: url) { [weak self]  (league: EventsResponse?) in
                             self?.eventResponse = league
                  self?.eventResult = league?.result
                          self?.bindResultToViewController()
            print("fetch on view modle")
            print("************\(self?.eventResult?[0])")
            print("----------------------------------")
           

        }
            
        
    }
        
       
    func fetchLatestResults(){
        let url = "\(Constants.bseUrl)\(sportName!)?met=Fixtures&leagueId=\(leagueId!)&from=\(Utlies.pastTime!)&to=\(Utlies.myCurrentTime!)&APIkey=\(Constants.apiKey)"
                  print("after fetch")
                  fetchData(url: url) { [weak self]  (league: EventsResponse?) in
                                   self?.eventResponse = league
                        self?.latestResults = league?.result
                                self?.bindResultToViewController()
                  print("fetch on view modle")
        
    }
}
    func fetchTeams()  {
        //https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=22ad8dd732a55a3fe4d2f4df34998396b28f2b23f9020add2c4c977342017644&leagueId=152
       let url = "\(Constants.bseUrl)football?met=Teams&leagueId=200&APIkey=\(Constants.apiKey)"
                      print("after fetch")
                      fetchData(url: url) { [weak self]  (league: Teams?) in
                                       self?.teamsResponse = league
                        self?.legueTeams = league?.result
                                    self?.bindResultToViewController()
                      print("fetch on view modle")
            
        }
    }
}

