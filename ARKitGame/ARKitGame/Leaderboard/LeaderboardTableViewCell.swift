//
//  LeaderboardTableViewCell.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 08/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    var playerPosition : String?
    var playerName : String?
    var playerScore : String?
    
    public static func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    var positionLabel : UILabel = {
        var l = UILabel()
        l.font = UIFont.systemFont(ofSize: 20)
        l.textColor = .white
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var nameLabel : UILabel = {
        var l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 20)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    var scoreLabel : UILabel = {
        var l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 20)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.prepareContentView()
        self.isUserInteractionEnabled = false
    }
    
    func prepareContentView() {
        self.contentView.addSubview(positionLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(scoreLabel)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        self.positionLabel.pinTopBottom(to: self.contentView)
        self.positionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15).isActive = true
        self.nameLabel.pinTopBottom(to: self.contentView)
        self.nameLabel.leftAnchor.constraint(equalTo: self.positionLabel.rightAnchor, constant: 10).isActive = true
        
        self.scoreLabel.pinTopBottom(to: self.contentView)
        self.scoreLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let position = playerPosition {
            self.positionLabel.text = position
        }
        
        if let name = playerName {
            self.nameLabel.text = name
        }
        
        if let score = playerScore {
            self.scoreLabel.text = score
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
