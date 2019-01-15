//
//  Dragon.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 13/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class Dragon  {
        var id: String
        var dragonTime: TimeInterval
        var movementKey: String
        var deadEffectPath: String
        var bitMaskCategory: BitMaskCategory
    
    init(id: String, time:TimeInterval, movementKey: String, deadEffectPath: String) {
      //  super.init()
        self.id = id
        self.dragonTime = time
        self.movementKey = movementKey
        self.bitMaskCategory = BitMaskCategory.target
        self.deadEffectPath = deadEffectPath
    }
    
}
