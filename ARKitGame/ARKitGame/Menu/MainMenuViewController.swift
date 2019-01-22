//
//  MainMenuViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 29/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let buttonsNamesArray = ["playButton", "creditsButton", "leaderboardButton"]
    var playButton = UIButton()
    var creditsButton = UIButton()
    var leaderboardButton = UIButton()
    let firebase = FirebaseServices.init()
    let buttonsWidth: CGFloat = 200.0
    let buttonsHeight: CGFloat = 50.0
    let topInset: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        var buttonsDict:[String: UIButton] = ["playButton": self.playButton, "creditsButton": self.creditsButton, "leaderboardButton": self.leaderboardButton ]
        var buttonsArray:[UIButton] = []
        for buttonName in buttonsNamesArray {
            self.prapareMenuButton(title: buttonName, menuButton: buttonsDict[buttonName]!)
            buttonsArray.append(buttonsDict[buttonName]!)
        }
        self.addTargetsForButtons()
        self.addStackView(butt: buttonsArray)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebase.getLeaderBoard()
    }
    
    func addStackView(butt: [UIButton])  {
        let stackView = UIStackView(arrangedSubviews: butt)
        stackView.axis = .vertical;
        stackView.distribution = .equalSpacing;
        stackView.alignment = .center;
        stackView.spacing = 30;
        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXY(to: self.view)
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon2")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    func prapareMenuButton(title: String, menuButton: UIButton) {
        menuButton.setTitle(NSLocalizedString(title, comment: "MenuButton"), for: .normal)
        menuButton.titleLabel?.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.setTitleColor(.gray, for: .selected)

        menuButton.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        menuButton.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        
        menuButton.layer.cornerRadius = 10
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.heightAnchor.constraint(equalToConstant: self.buttonsHeight).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: self.buttonsWidth).isActive = true
    }
    
    func addTargetsForButtons() {
        self.playButton.addTarget(self, action: #selector(self.playButtonClicked(_:)), for: .touchUpInside)
        self.creditsButton.addTarget(self, action: #selector(self.optionsButtonClicked(_:)), for: .touchUpInside)
        self.leaderboardButton.addTarget(self, action: #selector(self.leaderboardButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func playButtonClicked(_ sender:UIButton!) {
        let newViewController = PlayerNameViewController()//GameViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func optionsButtonClicked(_ sender:UIButton!) {
        let newViewController = CreditsViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func leaderboardButtonClicked(_ sender:UIButton!) {
        let newViewController = LeaderboardViewController(leaderboard: firebase.scoreData)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

}
