//
//  ApiNetworkService.swift
//  SportingApp
//
//  Created by maha on 5/24/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
import Alamofire
func fetchData<T: Decodable>(url: String, handler: @escaping (T?) -> Void) {
           Alamofire.request(url).responseJSON { response in
               switch response.result {
               case .success(let value):
                   do {
                       let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                       let leagueResponse = try JSONDecoder().decode(T.self, from: jsonData)
                       handler(leagueResponse)
                       print("success")
                       // print(leagueResponse.result?[0] ?? "not received")
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
