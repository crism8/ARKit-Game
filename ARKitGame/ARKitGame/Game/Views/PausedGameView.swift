//
//  PausedGameView.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 11/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class PausedGameView: UIView {
    
    var resumeButton: UIButton!
    var restartButton: UIButton!
    var quitButton: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTopBarView()
        self.resumeButton = self.praparePauseViewButton(title: "resumeButton")
        self.restartButton = self.praparePauseViewButton(title: "restartButton")
        self.quitButton = self.praparePauseViewButton(title: "quitButton")
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
        l.font = UIFont.systemFont(ofSize: 30.0)
        l.textColor = .white
        l.textAlignment = .center
        tBV.addSubview(l)
        l.pinAllEdges(to: tBV)
    }
    
    func praparePauseViewButton(title: String) -> UIButton {
        let pauseButton = UIButton(type: .roundedRect)
        pauseButton.setTitle(NSLocalizedString(title, comment: "PauseButton"), for: .normal)
        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 25.0)
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
        let stackView = UIStackView(arrangedSubviews: [resumeButton, restartButton, quitButton])
        stackView.axis = .vertical;
        stackView.distribution = .equalSpacing;
        stackView.alignment = .center;
        stackView.spacing = 30;
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXY(to: self)
    }
}
