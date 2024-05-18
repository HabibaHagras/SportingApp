//
//  NetworkServices.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
func fetchLeagues(for sport: String, handler: @escaping (LeagueResponse?) -> Void) {
let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=c89682f0a5d6ea43d1961761ea5adfb507df5320a61e1918ed0781e03ad20081&fbclid=IwZXh0bgNhZW0CMTAAAR3O-bHItUbdiNodf1zmAi48ZNdhsGe46gNYq972gXP-i-XPCsH--77FzX4_aem_AU8yYQORBt5XB1HWT_K3V6a4Zba6exdup7WqhG7ZbImoNE5nf3tt1KmwX3vtuLlQWPmZqksrypWvPPLjjMjhBU51"

guard let url = URL(string: urlString) else {
    print("Invalid URL")
    handler(nil)
    return
}
    
    let req = URLRequest(url: url)
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: req) { data, response, error in
        if let error = error {
            print("Error during data task: \(error.localizedDescription)")
            handler(nil)
            return
        }
        
        guard let data = data else {
            print("No data received")
            handler(nil)
            return
        }
        
        do {
            let leagueResponse = try JSONDecoder().decode(LeagueResponse.self, from: data)
            handler(leagueResponse)
            print(leagueResponse)
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
            print("Data:", data)

            handler(nil)
        }
    }
    
    task.resume()
}
