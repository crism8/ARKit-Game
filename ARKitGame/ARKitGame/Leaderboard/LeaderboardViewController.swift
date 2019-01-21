//
//  LeaderboardViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 20/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var LeaderboardModel = [LeadScore]()

    
    init(leaderboard: [LeadScore]) {
        super.init(nibName: nil, bundle: nil)
        self.LeaderboardModel = leaderboard
        self.sortModel()
        for item in LeaderboardModel {
            print(item.username, ":::", item.score)
        }
    }
    
    func sortModel() {
        self.LeaderboardModel.sort { (lhs:LeadScore, rhs:LeadScore)  in
            return lhs.score > rhs.score
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareBackground()
        self.prepareTableView()
    }
    

    func prepareBackground() {
        let image = UIImage(named: "dragon6")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    func prepareTableView() {
        self.tableView = UITableView()
        self.tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.cellIdentifier())
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // self.tableView.separatorStyle = .none

        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.pinAllEdges(to: self.view)
        self.tableView.backgroundColor = .clear
        self.tableView.isScrollEnabled = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeaderboardModel.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeaderboardTableViewCell.cellIdentifier(), for: indexPath as IndexPath) as! LeaderboardTableViewCell
        cell.playerPosition = String(indexPath.row+1)
        cell.playerName = LeaderboardModel[indexPath.row].username
        cell.playerScore = String(LeaderboardModel[indexPath.row].score)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
