//
//  PlayerModel.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import Foundation


struct LeaderboardPlayerModel: Codable{
    var profile_id: Int
    var rank: Int
    var rating: Int
    var name: String
    var games: Int
    var wins: Int
    
    var winPercentage: String{
        return String(format: "%2.f", (Float(wins) / Float(games)) * 100)
    }
}
