//
//  OptionsViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    var dragonCreditLabel: UILabel!
    var freePikCreditLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.dragonCreditLabel = self.addCreditLabel(title: "DragonCredit")
        self.freePikCreditLabel = self.addCreditLabel(title: "FreepikCredit")
      //  self.viewWillLayoutSubviews()
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon5")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    
    func addCreditLabel(title: String) -> UILabel {
        let l = UILabel()
        l.lineBreakMode = .byWordWrapping
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false;
        l.text = NSLocalizedString(title, comment: "CreditLabel")
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 20)
      //  l.textAlignment = .natural
        self.view.addSubview(l)
        return l
    }
    override func viewWillLayoutSubviews() {
        self.dragonCreditLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60.0).isActive = true
        self.dragonCreditLabel.pinLeftRight(to: self.view, offset: 15.0)
        self.freePikCreditLabel.pinLeftRight(to: self.view, offset: 15.0)
        self.freePikCreditLabel.topAnchor.constraint(equalTo: self.dragonCreditLabel.bottomAnchor, constant: 15.0).isActive = true
    }
    
}
