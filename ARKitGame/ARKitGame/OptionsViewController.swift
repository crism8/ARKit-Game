//
//  OptionsViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    let firebase = FirebaseServices.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackground()
        self.prapareFirebaseButton(title: "Send to Firebase")
        
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon4")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    func prapareFirebaseButton(title: String) {
        let menuButton = UIButton(type: .roundedRect)
        menuButton.setTitle(NSLocalizedString(title, comment: "MenuButton"), for: .normal)
        menuButton.titleLabel?.font = UIFont(name: "Baskerville-Bold ", size: 25.0)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.setTitleColor(.gray, for: .selected)
        
        menuButton.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        menuButton.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        
        menuButton.layer.cornerRadius = 10
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(menuButton)
        menuButton.pinAllEdges(to: self.view)
        menuButton.addTarget(self, action: #selector(self.firebaseButtonClicked(_:)), for: .touchUpInside)

       // menuButton.heightAnchor.constraint(equalToConstant: self.buttonsHeight).isActive = true
       // menuButton.widthAnchor.constraint(equalToConstant: self.buttonsWidth).isActive = true
        
        //playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        // playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        
        //   return menuButton
    }
    
    @objc func firebaseButtonClicked(_ sender:UIButton!) {
        print("firebase Button Clicked")
        firebase.sendScore()
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
