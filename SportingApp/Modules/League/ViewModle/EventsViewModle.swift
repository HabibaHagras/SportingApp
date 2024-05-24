//
//  EventsViewModle.swift
//  SportingApp
//
//  Created by maha on 5/20/24.

import Foundation
class EventsViewModle{
     var eventResponse: EventsResponse?
        var eventResult: [Event]? = []
        var latestResults: [Event]? = []
        
        var bindResultToViewController :(()->()) = {}

        
         func fetchUpcomingEvents() {
                let url = "\(Constants.bseUrl)football?met=Fixtures&leagueId=200&from=\(Utlies.currentTime!)&to=\(Utlies.futureTime!)&APIkey=\(Constants.apiKey)"
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
        let url = "\(Constants.bseUrl)football?met=Fixtures&leagueId=200&from=\(Utlies.pastTime!)&to=\(Utlies.myCurrentTime!)&APIkey=\(Constants.apiKey)"
                  print("after fetch")
                  fetchData(url: url) { [weak self]  (league: EventsResponse?) in
                                   self?.eventResponse = league
                        self?.latestResults = league?.result
                                self?.bindResultToViewController()
                  print("fetch on view modle")
        
    }
}

}
