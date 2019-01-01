//
//  ViewController.swift
//  ARKitGame
//
//  Created by Cristrian Makarski on 29/10/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit
//import SceneKit
import ARKit

enum BitMaskCategory: Int {
    case bullet = 2
    case target = 3
}

class ARKitViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let efectsArray = ["art.scnassets/Smoke.scnp", "art.scnassets/Bokeh.scnp", "art.scnassets/Fire.scnp", "art.scnassets/Reactor.scnp", "art.scnassets/Confetti.scnp"]
    var power: Float = 50
    var Target: SCNNode?
    var scoreLabel: UILabel = UILabel()
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSceneView()
        self.makeTrexButton()
        self.addGunSight()
        self.addScoreCounter()
    }
    
    func addSceneView() {
        self.sceneView = ARSCNView()
        self.view.addSubview(self.sceneView)
        self.sceneView.translatesAutoresizingMaskIntoConstraints = false
        self.sceneView.pinEdges(to: self.view)
        self.sceneView.delegate = self
        //self.sceneView.showsStatistics = true
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }
    
    func addGunSight() {
        let image = UIImage(named: "plus")
        let gunSight = UIImageView(image: image)
        self.view.addSubview(gunSight)
        gunSight.translatesAutoresizingMaskIntoConstraints = false
        gunSight.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gunSight.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    func addScoreCounter() {
        self.scoreLabel.text = String(self.score)
        self.scoreLabel.font = UIFont.systemFont(ofSize: 20)
        self.scoreLabel.textAlignment = .center
        self.view.addSubview(self.scoreLabel)
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scoreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.scoreLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run the view's session
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.sceneView.addGestureRecognizer(gestureRecognizer)
        self.sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        self.sceneView.session.pause()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let position = orientation + location
        let bullet = SCNNode(geometry: SCNSphere(radius: 0.1))
        bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        bullet.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bullet, options: nil))
        body.isAffectedByGravity = false
        bullet.physicsBody = body
        bullet.physicsBody?.applyForce(SCNVector3(orientation.x*power, orientation.y*power, orientation.z*power), asImpulse: true)
        bullet.physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
        bullet.physicsBody?.contactTestBitMask = BitMaskCategory.target.rawValue
        self.sceneView.scene.rootNode.addChildNode(bullet)
        bullet.runAction(
            SCNAction.sequence([SCNAction.wait(duration: 2.0),
                                SCNAction.removeFromParentNode()])
        )
    }
    
    func makeTrexButton() {
        let playButton = UIButton(type: .roundedRect)
        playButton.setTitle(NSLocalizedString("DragonButton", comment: "Button"), for: .normal)
        playButton.backgroundColor = .green
        playButton.addTarget(self, action: #selector(self.trexButtonClicked(_:)), for: .touchUpInside)
        
        playButton.titleEdgeInsets = UIEdgeInsets(top: -10,left: -10,bottom: -10,right: -10)
        playButton.contentEdgeInsets = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
        view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        let margins = view.layoutMarginsGuide
        playButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    }
    
    @objc func trexButtonClicked(_ sender:UIButton!) {
     print("sample Button Clicked")
        self.addNoEyedDragon(x: 5, y: 0, z: -10)
        self.addNoEyedDragon(x: 0, y: 0, z: -10)
        self.addNoEyedDragon(x: -5, y: 0, z: -10)
     }
    
    func addNoEyedDragon(x: Float, y: Float, z: Float) {
        
        //let trexScene =  SCNScene(named: "art.scnassets/egg.scn")
       // let trexNode = (trexScene?.rootNode.childNode(withName: "egg", recursively: false))!
        let trexScene =  SCNScene(named: "art.scnassets/No_Eyed_Dragon.scn")
        let trexNode = (trexScene?.rootNode.childNode(withName: "No_Eyed_Dragon", recursively: false))!
       // let trexScene =  SCNScene(named: "art.scnassets/ship.scn")
      //  let trexNode = (trexScene?.rootNode.childNode(withName: "ship", recursively: false))!
       //  let trexScene =  SCNScene(named: "art.scnassets/dragonglare.scn")
       //  let trexNode = (trexScene?.rootNode.childNode(withName: "dragon", recursively: false))!
        trexNode.position = SCNVector3(x,y,z)
        trexNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: trexNode, options: nil))
        trexNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        trexNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        self.sceneView.scene.rootNode.addChildNode(trexNode)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeB
        }
        
        let confetti = SCNParticleSystem(named: efectsArray[Int.random(in: 0 ... efectsArray.count-1)], inDirectory: nil)
        confetti?.loops = false
        confetti?.particleLifeSpan = 4
        confetti?.emitterShape = SCNSphere(radius: 1)
        let confettiNode = SCNNode()
        confettiNode.addParticleSystem(confetti!)
        confettiNode.position = contact.contactPoint
        self.sceneView.scene.rootNode.addChildNode(confettiNode)
        Target?.removeFromParentNode()
        self.addNoEyedDragon(x: Float.random(in: -5.0 ... 5.0), y: Float.random(in: -5.0 ... 5.0), z: Float.random(in: -5.0 ... 5.0))
    }
    
    func updateScore() {
        DispatchQueue.main.async {
            self.score =  self.score+1
            self.scoreLabel.text = String(self.score)
        }
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

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}
