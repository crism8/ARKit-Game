//
//  OptionsViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    let firebase = FirebaseServices.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackground()        
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon4")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
}
