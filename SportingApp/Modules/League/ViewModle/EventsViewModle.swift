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
        
        var bindResultToViewController :(()->()) = {}

        
         func fetchUpcomingEvents() {
            print("after fetch")
           fetchEvents() { [weak self] league in
                             self?.eventResponse = league
                  self?.eventResult = league?.result
                          self?.bindResultToViewController()
            print("fetch on view modle")
            print("************\(self?.eventResult?[0])")
            print("----------------------------------")
           

        }
            
        
    }
        
       
}
