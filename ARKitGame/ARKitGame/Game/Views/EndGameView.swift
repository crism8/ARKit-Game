//
//  EndGameView.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 21/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class EndGameView: UIView {

    var scoreTextLabel: UILabel!
    var scoreLabel: UILabel!
    var playerNameLabel: UILabel!

    var scoreView: UIView!

    var restartButton: UIButton!
    var quitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTopBarView()
        self.scoreTextLabel = self.prepareScoreLabel()
        self.scoreView = self.prepareScoreView()
        self.restartButton = self.prapareEndViewButton(title: "restartButton")
        self.quitButton = self.prapareEndViewButton(title: "quitButton")
        self.addStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTopBarView() {
        let tBV = UIView()
        tBV.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        self.addSubview(tBV)
        tBV.translatesAutoresizingMaskIntoConstraints = false
        tBV.pinTopLeftRight(to: self)
        tBV.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "DRAGON SHOOTER"
        l.font = UIFont.systemFont(ofSize: 30)
        l.textColor = .white
        tBV.addSubview(l)
        l.textAlignment = .center
        l.pinAllEdges(to: tBV)
    }
    
    func prepareScoreLabel() -> UILabel {
        let l = UILabel()
        l.text = "SCORE"
        l.font = UIFont.systemFont(ofSize: 25.0)
        l.textAlignment = .center
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        l.heightAnchor.constraint(equalToConstant: 50).isActive = true
        l.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return l
    }
    
    func prepareScoreView() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.widthAnchor.constraint(equalToConstant: 200).isActive = true
        let playerNameL = UILabel()
        playerNameL.text = ""
        playerNameL.font = UIFont.systemFont(ofSize: 25.0)
        playerNameL.textAlignment = .center
        playerNameL.textColor = .white
        playerNameL.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(playerNameL)
        
        let playerScoreL = UILabel()
        playerScoreL.text = ""
        playerScoreL.font = UIFont.systemFont(ofSize: 25.0)
        playerScoreL.textAlignment = .center
        playerScoreL.textColor = .white
        playerScoreL.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(playerScoreL)
        
        playerNameL.pinTopBottom(to: v)
        playerScoreL.pinTopBottom(to: v)
        
        playerNameL.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 15).isActive = true
        playerScoreL.leftAnchor.constraint(equalTo: playerNameL.rightAnchor, constant: 15).isActive = true
        self.playerNameLabel = playerNameL
        self.scoreLabel = playerScoreL

        return v
    }
    
    func prapareEndViewButton(title: String) -> UIButton {
        let endButton = UIButton(type: .roundedRect)
        endButton.setTitle(NSLocalizedString(title, comment: "endButton"), for: .normal)
        endButton.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
        endButton.setTitleColor(.white, for: .normal)
        endButton.setTitleColor(.gray, for: .selected)
        
        endButton.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        endButton.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        
        endButton.layer.cornerRadius = 10
        endButton.translatesAutoresizingMaskIntoConstraints = false
        endButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        endButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

        
        return endButton
    }
    
    func addStackView()  {
        let stackView = UIStackView(arrangedSubviews: [scoreTextLabel, scoreView, restartButton, quitButton])
        stackView.axis = .vertical;
        stackView.distribution = .equalSpacing;
        stackView.alignment = .center;
        stackView.spacing = 30;
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXY(to: self)
    }
}
