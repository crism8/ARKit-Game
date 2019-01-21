//
//  LeaderboardViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 08/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.cellIdentifier())
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.cellIdentifier()) as! LeaderboardTableViewCell
        cell.playerPosition = String(indexPath.row)
        cell.playerPosition = String(indexPath.row)
        cell.playerName = String(indexPath.row) + "NAME"
        cell.playerScore = String(indexPath.row) + "SCORE"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;

    }

}
