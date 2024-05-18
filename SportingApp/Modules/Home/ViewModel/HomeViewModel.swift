//
//  HomeViewModel.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation

class HomeViewModel {
    var leagueResponseVar: LeagueResponse?
    var LeagueResultVar : [League]? = []
    var sport_name :String!
    var bindResultToViewController :(()->()) = {}

    
     func fetchLeaguesViewModel(for sport: String) {
       fetchLeagues(for: sport) { [weak self] league in
                   self?.leagueResponseVar = league
        self?.LeagueResultVar = league?.result
                self?.bindResultToViewController() 

    }
        
    
    
    
    
}
}
