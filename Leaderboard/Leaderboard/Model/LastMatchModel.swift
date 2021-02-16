//
//  LastMatchModel.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import Foundation


struct LastMatchModel: Codable{
    var name: String
    var map_type: Int
    var started: Int
    var finished: Int?
    var players: [MatchPlayerModel]
    
    
    var roundTime: Int? {
        guard let finished = finished else {return nil}
        return (finished - started) / 60
    }
}
