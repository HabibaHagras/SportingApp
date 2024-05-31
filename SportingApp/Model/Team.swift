//
//  Team.swift
//  SportingApp
//
//  Created by habiba on 5/31/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation

struct Teams: Codable {
    let success: Int?
    let result: [Team]?
}

// MARK: - Team
struct Team: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?
    let players: [Player]?



    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}
