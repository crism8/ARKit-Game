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
    
    func sendScore(dict:NSDictionary) {
        self.leaderboardDatabaseReference?.childByAutoId().setValue(dict)
    }
    
    func getLeaderBoard() {
        self.leaderboardDatabaseReference?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshotValue = snapshot.value as? [String:NSDictionary] {
                var tempScoreData = [LeadScore]()
                for snapDict in snapshotValue {
                let name = snapDict.value["playerName"] as! String
                let score = snapDict.value["score"] as! String
                let lS = LeadScore(username: name, score: Int(score)!)
                tempScoreData.append(lS)
                }
                self.scoreData = tempScoreData
            }
        }){ (error) in
            print(error.localizedDescription)
        }
    }
    
}
