//
//  MatchPlayerModel.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import Foundation


struct MatchPlayerModel: Codable{
    var name: String
    var civ: Int
    var won: Bool?
}
