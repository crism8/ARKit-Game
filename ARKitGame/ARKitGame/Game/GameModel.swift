//
//  GameModel.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 14/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import Foundation

class GameModel  {
    var score: Int
    var time: TimeInterval
    var playerName: String
    var dragon: Dragon
    
    init(score: Int, time: TimeInterval, playerName: String, dragon: Dragon) {
        self.score = score
        self.time = time
        self.playerName = playerName
        self.dragon = dragon
    }
    
}
