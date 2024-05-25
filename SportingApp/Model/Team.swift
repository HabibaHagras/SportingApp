//
//  Team.swift
//  SportingApp
//
//  Created by maha on 5/23/24.
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


    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}
