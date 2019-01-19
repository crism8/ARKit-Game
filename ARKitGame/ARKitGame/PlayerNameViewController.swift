//
//  PlayerNameViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 18/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class PlayerNameViewController: UIViewController, UITextFieldDelegate {
    
    let playerNameLabel = UILabel()
    var playerName = "Dragon Slayer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackground()
        self.addPlayerNameLabel()
        self.addPlayerNameTextField()
    }
    

    func addBackground() {
        let image = UIImage(named: "dragon8")
        let background = UIImageView(image: image)
        self.view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.pinAllEdges(to: self.view)
        background.contentMode = .scaleAspectFill
    }
    
    func addPlayerNameLabel() {
        self.playerNameLabel.text = NSLocalizedString("playerNameLabel", comment: "playerLabel")
        self.playerNameLabel.font = UIFont.systemFont(ofSize: 20)
        self.playerNameLabel.textAlignment = .center
        self.view.addSubview(self.playerNameLabel)
        self.playerNameLabel.translatesAutoresizingMaskIntoConstraints = false

        self.playerNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true
        self.playerNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.playerNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.playerNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }
    
    func addPlayerNameTextField() {
        let sampleTextField =  UITextField()
        sampleTextField.placeholder = "Dragon Slayer"
        sampleTextField.font = UIFont.systemFont(ofSize: 20)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.delegate = self
        self.view.addSubview(sampleTextField)
       sampleTextField.translatesAutoresizingMaskIntoConstraints = false

        sampleTextField.topAnchor.constraint(equalTo: self.playerNameLabel.bottomAnchor).isActive = true
        sampleTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sampleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        sampleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
        guard case self.playerName = textField.text else {
            print("textField.text else")

            self.playerName = "Dragon Slayer"
            return
        }
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
       // self.playerName = textField.text!
        textField.resignFirstResponder();

        return false
    }

}
