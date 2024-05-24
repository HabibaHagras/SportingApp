//
//  Team.swift
//  SportingApp
//
//  Created by maha on 5/23/24.
//  Copyright © 2024 habiba. All rights reserved.
//

import Foundation

// MARK: - TeamModel
struct TeamResponse: Codable {
    let success: Int
    let result: [Team]
}

// MARK: - Team
struct Team: Codable {
    let teamKey: String
    let teamName: String
    let teamLogo: String
    let players: [Player]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players
    }
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int
    let playerName: String
    let playerNumber: String?
    let playerCountry: String?
    let playerType: String
    let playerAge: String?
    let playerMatchPlayed: String?
    let playerGoals: String?
    let playerYellowCards: String?
    let playerRedCards: String?
    let playerImage: String

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerImage = "player_image"
    }
}
