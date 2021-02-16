//
//  LeaderboardResponse.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import Foundation


struct LeaderboardResponse: Codable {
    var leaderboard: [LeaderboardPlayerModel]
}
