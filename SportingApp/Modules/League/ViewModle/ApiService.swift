//
//  ApiService.swift
//  SportingApp
//
//  Created by maha on 5/20/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import Alamofire
func fetchEvents(for sport: String, handler: @escaping (EventsResponse?) -> Void) {
    let urlString = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=200&from=2023-01-18&to=2024-01-18&APIkey=5875401c7bbc5187abf58be03796ab2a39d557ac08f6ff6a22d8f57dff7a62ef"

    Alamofire.request(urlString).responseJSON { response in
        switch response.result {
        case .success(let value):
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let leagueResponse = try JSONDecoder().decode(EventsResponse.self, from: jsonData)
                handler(leagueResponse)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                handler(nil)
            }
        case .failure(let error):
            print("Error fetching leagues: \(error.localizedDescription)")
            handler(nil)
        }
    }
}
