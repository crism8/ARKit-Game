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
    
    var positionTextView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var nameTextView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var scoreTextView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(positionTextView)
        addSubview(nameTextView)
        addSubview(scoreTextView)
        
        self.positionTextView.pinEdgesToLeft(to: self)
        
        self.nameTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.scoreTextView.pinEdgesToRight(to: self)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let position = playerPosition {
            positionTextView.text = position
        }
        
        if let name = playerName {
            nameTextView.text = name
        }
        
        if let score = playerScore {
            scoreTextView.text = score
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
