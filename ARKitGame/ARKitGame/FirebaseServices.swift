//
//  FirebaseServices.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 09/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseServices: NSObject {
    let leaderboardDatabaseReference: DatabaseReference?
    
    override init() {
        self.leaderboardDatabaseReference = Database.database().reference(withPath: "Leaderboard")
    }
    
    func sendScore() {
        let dict = ["playerName": "Cris", "score": "133"]
        self.leaderboardDatabaseReference?.childByAutoId().setValue(dict)
    }
}
