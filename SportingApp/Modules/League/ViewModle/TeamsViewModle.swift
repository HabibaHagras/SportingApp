////
////  TeamsViewModle.swift
////  SportingApp
////
////  Created by maha on 5/24/24.
////  Copyright © 2024 habiba. All rights reserved.
////
//
//import Foundation
//class TeamsViewModle{
//    var teamsResponse: TeamResponse?
//           var teamResult: [Team]? = []
//           
//           var bindResultToViewController :(()->()) = {}
//
//           
//            func fetchTeams() {
//               
//               let urlString = "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=200&from=2023-01-18&to=2024-01-18&APIkey=5875401c7bbc5187abf58be03796ab2a39d557ac08f6ff6a22d8f57dff7a62ef"
//               print("after fetch")
//               fetchData(url: urlString) { [weak self] team in
//                   self?.teamsResponse = team
//                   self?.teamResult = team?.result
//                   self?.bindResultToViewController()
//                   print("fetch on view modle")
//                   print("************\(self?.teamResult?[0])")
//                   print("----------------------------------")
//                   
//                   
//               }
//               
//           
//       }
//}
