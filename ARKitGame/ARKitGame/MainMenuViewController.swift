//
//  MainMenuViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 29/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    let buttonsNamesArray = ["playButton", "optionsButton", "leaderboardButton"]
    var buttonsArray:[UIButton] = []
    var playButton = UIButton()
    var optionsButton = UIButton()
    var leaderboardButton = UIButton()

    let buttonsWidth: CGFloat = 200.0
    let buttonsHeight: CGFloat = 50.0
    let topInset: CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        var buttonsDict:[String: UIButton] = ["playButton": self.playButton, "optionsButton": self.optionsButton, "leaderboardButton": self.leaderboardButton ]
        for buttonName in buttonsNamesArray {
            self.prapareMenuButton(title: buttonName, menuButton: buttonsDict[buttonName]!)
            self.buttonsArray.append(buttonsDict[buttonName]!)
        }
        self.addTargetsForButtons()
        self.addStackView(butt: self.buttonsArray)
    }
    
    func addStackView(butt: [UIButton])  {
        let stackView = UIStackView(arrangedSubviews: butt)
        stackView.axis = .vertical;
        stackView.distribution = .equalSpacing;
        stackView.alignment = .center;
        stackView.spacing = 30;
        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon2")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinEdges(to: self.view)
        background.contentMode = .scaleAspectFill

    }
    
    func prapareMenuButton(title: String, menuButton: UIButton) {
        //let menuButton = UIButton(type: .roundedRect)
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
        
        //playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        // playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)

     //   return menuButton
    }
    
    func addTargetsForButtons() {
        self.playButton.addTarget(self, action: #selector(self.playButtonClicked(_:)), for: .touchUpInside)
        self.optionsButton.addTarget(self, action: #selector(self.optionsButtonClicked(_:)), for: .touchUpInside)
        self.leaderboardButton.addTarget(self, action: #selector(self.leaderboardButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func playButtonClicked(_ sender:UIButton!) {
        print("play Button Clicked")
        let newViewController = ARKitViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    @objc func optionsButtonClicked(_ sender:UIButton!) {
        print("options Button Clicked")
        
    }
    
    @objc func leaderboardButtonClicked(_ sender:UIButton!) {
        print("leaderboard Button Clicked")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}