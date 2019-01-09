//
//  LeaderboardViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 08/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class LeaderboardViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareBackground()
        self.tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: LeaderboardTableViewCell.cellIdentifier())
    }
    
    func prepareBackground() {
        let image = UIImage(named: "dragon6")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;

    }

}
