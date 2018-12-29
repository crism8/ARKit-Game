//
//  MainMenuViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 29/12/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.addPlayButton()
    }
    
    func addBackground() {
        let image = UIImage(named: "dragon4")
        let background = UIImageView(image: image)
        background.contentMode = .scaleAspectFill
        self.view = background
    }
    
    func addPlayButton() {
        let playButton = UIButton()//UIButton(type: .system)
      //  playButton.frame.size = CGSize(width: 100, height: 20)
        playButton.setTitle(NSLocalizedString("PlayButton", comment: "Button"), for: .normal)
        playButton.backgroundColor = .blue
        playButton.addTarget(self, action: #selector(self.playButtonClicked(_:)), for: .touchUpInside)
        playButton.layer.cornerRadius = 4

        //playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
       // playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true

    }
    
    @objc func playButtonClicked(_ sender:UIButton!) {
        print("sample Button Clicked")
        
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
