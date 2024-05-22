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
}

extension MockNetwork {
    enum ResponseWithError: Error {
        case responseError
    }
    
    func fetchDataFromApi(completionHandler: @escaping (LeagueResponse?, Error?) -> Void) {
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
}
