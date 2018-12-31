//
//  OptionsViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 31/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addBackground()
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon4")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinEdges(to: self.view)
        background.contentMode = .scaleAspectFill
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
