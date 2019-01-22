//
//  GameView.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 14/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit
import ARKit

//<div>Icons made by <a href="https://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"                 title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"                 title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

class GameView: UIView {
    
    var sceneView: ARSCNView!
    var gunSight: UIImageView!
    var scoreLabel: UILabel!
    var timeLabel: UILabel!
    var startButton: UIButton!
    var pauseButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSceneView()
        self.addGunSight()
        self.addScoreCounter()
        self.addStartButton()
        self.addPauseButton()
        self.addTimeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSceneView() {
        self.sceneView = ARSCNView()
        self.addSubview(self.sceneView)
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.sceneView.pinAllEdges(to: self)
        //self.sceneView.showsStatistics = true
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    func addGunSight() {
        let image = UIImage(named: "plus")
        let gunSight = UIImageView(image: image)
        self.addSubview(gunSight)
        self.gunSight = gunSight
        self.gunSight.translatesAutoresizingMaskIntoConstraints = false
        self.gunSight.centerXY(to: self)
    }
    
    
    func addScoreCounter() {
        let scoreTextLabel = UILabel()
        scoreTextLabel.text = NSLocalizedString("scoreLabel", comment: "MenuButton")
        scoreTextLabel.font = UIFont.systemFont(ofSize: 20)
        scoreTextLabel.textAlignment = .center
        self.addSubview(scoreTextLabel)
        scoreTextLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scoreTextLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        self.scoreLabel = UILabel()
        self.scoreLabel.text = String(0)
        self.scoreLabel.font = UIFont.systemFont(ofSize: 20)
        self.scoreLabel.textAlignment = .center
        self.addSubview(self.scoreLabel)
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.scoreLabel.topAnchor.constraint(equalTo: scoreTextLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func addStartButton() {
        let startButton = UIButton(type: .roundedRect)
        startButton.setTitle(NSLocalizedString("startButton", comment: "Button"), for: .normal)
        //startButton.addTarget(self, action: #selector(self.trexButtonClicked(_:)), for: .touchUpInside)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitleColor(.gray, for: .selected)
        startButton.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        startButton.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        startButton.layer.cornerRadius = 10
        self.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        startButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        startButton.centerXY(to: self)
        self.startButton = startButton
        }
    
    func addPauseButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named:"pause-button.png"), for: .normal)
        button.setImage(UIImage(named:"pause-button-selected.png"), for: .highlighted)
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        button.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.pauseButton = button
    }
    
    func addTimeLabel() {
        self.timeLabel = UILabel()
        self.timeLabel.text = String(60)
        self.timeLabel.font = UIFont.systemFont(ofSize: 40)
        self.timeLabel.textAlignment = .center
        self.addSubview(self.timeLabel)
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.timeLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.timeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
    }
}
