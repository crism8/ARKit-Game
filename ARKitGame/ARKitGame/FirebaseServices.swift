//
//  FirebaseServices.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 09/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit
import FirebaseDatabase


struct LeadScore {
    var username: String
    var score: Int
}


class FirebaseServices: NSObject {
    let leaderboardDatabaseReference: DatabaseReference?
    var scoreData = [LeadScore]()
    override init() {
        self.leaderboardDatabaseReference = Database.database().reference(withPath: "Leaderboard")
    }
    
    func sendScore() {
        let dict = ["playerName": "Cris", "score": 133] as! [String : Int]
        self.leaderboardDatabaseReference?.childByAutoId().setValue(dict)
    }
    func getLeaderBoard() {
        self.leaderboardDatabaseReference?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshotValue = snapshot.value as? [String:NSDictionary] {
                for snapDict in snapshotValue {
                let name = snapDict.value["playerName"] as! String
                let score = snapDict.value["score"] as! Int
                let lS = LeadScore(username: name, score: score)
                    
                print(name, score)
                self.scoreData.append(lS)

                }
            }
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
}
