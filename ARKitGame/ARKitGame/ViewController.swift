//
//  ViewController.swift
//  ARKitGame
//
//  Created by Cristrian Makarski on 29/10/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        self.makeTrexButton()
         self.makeShipButton()
    }
    
    func makeTrexButton() {
        let playButton = UIButton(type: .roundedRect)
        playButton.setTitle(NSLocalizedString("ButtonTrex", comment: "Button"), for: .normal)
        playButton.backgroundColor = .green
        playButton.addTarget(self, action: #selector(self.trexButtonClicked(_:)), for: .touchUpInside)
        
        playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomButtonConstraint = playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let margins = view.layoutMarginsGuide
        let leadingButtonConstraint = playButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        
        bottomButtonConstraint.isActive = true
        leadingButtonConstraint.isActive = true
    }
    
    @objc func trexButtonClicked(_ sender:UIButton!) {
     
     print("sample Button Clicked")
    // self.addTrex()
     self.addNoEyedDragon()
     }
    
    func makeShipButton() {
        let playButton = UIButton(type: .roundedRect)
        playButton.setTitle(NSLocalizedString("ButtonShip", comment: "Button"), for: .normal)
        playButton.backgroundColor = .green
        playButton.addTarget(self, action: #selector(self.shipButtonClicked(_:)), for: .touchUpInside)
        
        playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        let bottomButtonConstraint = playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let margins = view.layoutMarginsGuide
        let leadingButtonConstraint = playButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        bottomButtonConstraint.isActive = true
        leadingButtonConstraint.isActive = true
    }
    
    @objc func shipButtonClicked(_ sender:UIButton!) {
        
        print("sample Button Clicked")
        //self.addShip()
        //self.addButterFlyDragon()
        self.addDragonglare()
    }
    
    func addTrex() {
        let trexScene =  SCNScene(named: "art.scnassets/Tyrannosaurus.scn")
        let trexNode = trexScene?.rootNode.childNode(withName: "Trex", recursively: false)
        trexNode?.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(trexNode!)

    }
    
    func addShip() {

        let trexScene =  SCNScene(named: "art.scnassets/ship.scn")
        let trexNode = trexScene?.rootNode.childNode(withName: "ship", recursively: false)
        trexNode?.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(trexNode!)
        
    }
    
    func addDragonglare() {
        
        let trexScene =  SCNScene(named: "art.scnassets/dragonglare.scn")
        let trexNode = trexScene?.rootNode.childNode(withName: "dragon", recursively: false)
        trexNode?.position = SCNVector3(0,0,-2)
        self.sceneView.scene.rootNode.addChildNode(trexNode!)
        
    }
    
    func addButterFlyDragon() {
        
        let trexScene =  SCNScene(named: "art.scnassets/butterfly_dragon.scn")
        let trexNode = trexScene?.rootNode.childNode(withName: "body", recursively: false)
        trexNode?.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(trexNode!)
        
    }
    
    func addNoEyedDragon() {
        
        let trexScene =  SCNScene(named: "art.scnassets/No_Eyed_Dragon.scn")
        let trexNode = trexScene?.rootNode.childNode(withName: "No_Eyed_Dragon", recursively: false)
        trexNode?.position = SCNVector3(0,1,-1)
        self.sceneView.scene.rootNode.addChildNode(trexNode!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
