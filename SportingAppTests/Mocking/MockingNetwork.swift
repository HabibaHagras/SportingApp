//
//  MockingNetwork.swift
//  SportingAppTests
//
//  Created by habiba on 5/21/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation
@testable import SportingApp


class MockNetwork {
    
    var result = LeagueResponse(success: 1, result: [League(leagueKey: 2833, leagueName: "Aachen", countryKey: 281, countryName: "Challenger Men Singles", leagueLogo: nil, countryLogo: nil, league_year: nil)])
    
    var shouldreturnError : Bool
        init(shouldreturnError: Bool) {
           self.shouldreturnError = shouldreturnError
       }
    
    let fakeJSONObj: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 2833,
                "league_name": "Aachen",
                "country_key": 281,
                "country_name": "Challenger Men Singles"
            ]
        ]
    ]
   var event = EventsResponse(success: 1, result: [Event(
       eventKey: 1234,
       eventDate: "22 -9",
       eventTime: "7.0",
       eventHomeTeam: "Home Team",
       homeTeamKey: 1,
       eventAwayTeam: "Away Team",
       awayTeamKey: 2,
       eventFinalResult: "Final Result",
       eventQuarter: "Quarter",
       eventStatus: "Status",
       countryName: "Country Name",
       leagueName: "League Name",
       leagueKey: 3,
       leagueRound: "Round",
       leagueSeason: "Season",
       eventLive: "Live",
       eventHomeTeamLogo: "Home Team Logo",
       eventAwayTeamLogo: "Away Team Logo",
       homeTeamLogo: "Home Team Logo",
       awayTeamLogo: "Away Team Logo",
       eventFirstPlayer: "First Player",
       firstPlayerKey: "First Player Key",
       eventSecondPlayer: "Second Player",
       secondPlayerKey: "Second Player Key",
       eventFirstPlayerLogo: "First Player Logo",
       eventSecondPlayerLogo: "Second Player Logo",
       leagueLogo: "League Logo"
   )])
   let fakeEventJsonObject: [String: Any] = [
       "result": [
           [
               "event_key": 1333854,
               "event_date": "2023-11-10",
               "event_time": "20:45",
               "event_home_team": "Waterford",
               "home_team_key": 4779,
               "event_away_team": "Cork City",
               "away_team_key": 4770,
               "event_halftime_result": "0 - 0",
               "event_final_result": "2 - 1",
               "event_ft_result": "1 - 1",
               "event_penalty_result": "",
               "event_status": "After ET",
               "country_name": "Ireland",
               "league_name": "Premier Division - Finals",
               "league_key": 200,
               "league_round": "",
               "league_season": "2023",
               "event_live": "0",
               "event_stadium": "Tallaght Stadium (Dublin)",
               "event_referee": "D. McGraith",
               "home_team_logo": "https://apiv2.allsportsapi.com/logo/4779_waterford.jpg",
               "away_team_logo": "https://apiv2.allsportsapi.com/logo/4770_cork-city.jpg",
               "event_country_key": 61,
               "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/200_premier-division.png"
           ]
       ]
   ]

}

extension MockNetwork {
    enum ResponseWithError: Error {
        case responseError
    }
    
    func fetchLeaguesFromApi(completionHandler: @escaping (LeagueResponse?, Error?) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJSONObj)
            let decodedResult = try JSONDecoder().decode(LeagueResponse.self, from: data)
            self.result = decodedResult
        } catch {
            print(error.localizedDescription)
        }
        
        if shouldreturnError {
            completionHandler(nil, ResponseWithError.responseError)
        } else {
            completionHandler(result, nil)
        }
    }
 func fetchData<T: Decodable>(url: String, handler: @escaping (T?) -> Void) {
        
        DispatchQueue.global().async {
            if self.shouldreturnError {
                print("Error fetching data")
                handler(nil)
            } else {
                let jsonData = try! JSONSerialization.data(withJSONObject: self.fakeEventJsonObject, options: [])
                do {
                    let response = try JSONDecoder().decode(T.self, from: jsonData)
                    handler(response)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                    handler(nil)
                }
            }
        }
    }
   
    
}
