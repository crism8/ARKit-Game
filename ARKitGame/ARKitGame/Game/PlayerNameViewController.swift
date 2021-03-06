//
//  PlayerNameViewController.swift
//  ARKitGame
//
//  Created by Cristian Makarski on 18/01/2019.
//  Copyright © 2019 Cristrian Makarski. All rights reserved.
//

import UIKit

class PlayerNameViewController: UIViewController, UITextFieldDelegate {
    static let defaultName = "Dragon Slayer"
    static let offsets: CGFloat = 10.0
    let playerNameLabel = UILabel()
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBackground()
        self.addPlayerNameLabel()
        self.addPlayerNameTextField()
        self.addOkButton()
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

        self.layoutPlayerNameLabel()
    }
    
    func layoutPlayerNameLabel() {
        self.playerNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true
        self.playerNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.playerNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.playerNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func addPlayerNameTextField() {
        self.textField.placeholder = PlayerNameViewController.defaultName
        self.textField.font = UIFont.systemFont(ofSize: 20)
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.autocorrectionType = UITextAutocorrectionType.no
        self.textField.keyboardType = UIKeyboardType.default
        self.textField.returnKeyType = UIReturnKeyType.done
        self.textField.clearButtonMode = UITextField.ViewMode.whileEditing
        self.textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        self.textField.delegate = self
        self.layoutTextView()
    }
    
    func layoutTextView() {
        self.view.addSubview(self.textField)
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.topAnchor.constraint(equalTo: self.playerNameLabel.bottomAnchor).isActive = true
        self.textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.textField.pinLeftRight(to: self.view, offset: PlayerNameViewController.offsets)
        self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func addOkButton() {
        let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("OK", comment: "Button"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.backgroundColor = UIColor(red: 0.55, green: 0.78, blue: 0.93, alpha: 1.0)
        button.tintColor = UIColor(red: 0.25, green: 0.47, blue: 0.61, alpha: 1.0)
        button.layer.cornerRadius = 10
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.pinLeftRight(to: self.view, offset: PlayerNameViewController.offsets)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 5).isActive = true
        button.addTarget(self, action: #selector(self.okButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func okButtonClicked(_ sender:UIButton!) {
        let name = self.textField.text ?? PlayerNameViewController.defaultName
        let newViewController = GameViewController(playerName: name)
        self.navigationController?.present(newViewController, animated: true)
        self.navigationController?.popViewController(animated: false)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return false
    }
}
