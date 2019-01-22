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
        self.scoreTextLabel = self.prepareScoreLabel()//self.praparePauseViewButton(title: "resumeButton")
        self.scoreView = self.prepareScoreView()
        self.restartButton = self.praparePauseViewButton(title: "restartButton")
        self.quitButton = self.praparePauseViewButton(title: "quitButton")
        self.addStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTopBarView() {
        let tBV = UIView()
        tBV.backgroundColor = .black
        self.addSubview(tBV)
        tBV.translatesAutoresizingMaskIntoConstraints = false
        tBV.pinTopLeftRight(to: self)
        tBV.heightAnchor.constraint(equalToConstant: 100).isActive = true
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "DRAGON SHOOTER"
        l.font = UIFont(name: "Baskerville-Bold ", size: 50.0)
        l.textColor = .white
        tBV.addSubview(l)
        l.textAlignment = .center
        l.pinAllEdges(to: tBV)
    }
    
    func prepareScoreLabel() -> UILabel {
        let l = UILabel()
        l.text = "SCORE"
        l.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
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
        playerNameL.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
        playerNameL.textAlignment = .center
        playerNameL.textColor = .white
        playerNameL.translatesAutoresizingMaskIntoConstraints = false
        v.addSubview(playerNameL)
        
        let playerScoreL = UILabel()
        playerScoreL.text = ""
        playerScoreL.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
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
    
    func praparePauseViewButton(title: String) -> UIButton {
        let pauseButton = UIButton(type: .roundedRect)
        pauseButton.setTitle(NSLocalizedString(title, comment: "PauseButton"), for: .normal)
        pauseButton.titleLabel?.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
        pauseButton.setTitleColor(.white, for: .normal)
        pauseButton.setTitleColor(.gray, for: .selected)
        
        pauseButton.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        pauseButton.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        
        pauseButton.layer.cornerRadius = 10
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

        
        return pauseButton
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
