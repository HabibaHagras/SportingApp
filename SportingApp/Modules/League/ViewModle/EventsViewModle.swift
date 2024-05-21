//
//  EventsViewModle.swift
//  SportingApp
//
//  Created by maha on 5/20/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
class EventsViewModle{
     var eventResponse: EventsResponse?
        var eventResult: [Event]? = []
        var sport_name :String!
        var bindResultToViewController :(()->()) = {}

        
         func fetchLeaguesViewModel(for event: String) {
           fetchEvents(for: event) { [weak self] league in
                             self?.eventResponse = league
                  self?.eventResult = league?.result
                          self?.bindResultToViewController()

        }
        
    }
        
       
}
