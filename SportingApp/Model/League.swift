//
//  League.swift
//  SportingApp
//
//  Created by habiba on 5/18/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation

struct LeagueResponse: Codable {
    let success: Int
    var result: [League]
}

struct League: Codable {
    var leagueKey: Int
    var leagueName: String
    var countryKey: Int
    var countryName: String
    var leagueLogo: String?
    var countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}

