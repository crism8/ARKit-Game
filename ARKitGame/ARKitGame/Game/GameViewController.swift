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

class GameViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {

    //var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    let efectsArray = ["art.scnassets/Smoke.scnp", "art.scnassets/Bokeh.scnp", "art.scnassets/Fire.scnp", "art.scnassets/Reactor.scnp", "art.scnassets/Confetti.scnp"]
    var power: Float = 25
    var Target: SCNNode?
    var score: Int = 0
    let gameView = GameView()
    var timer = Timer()
    var gameTime = 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gameView
        self.gameView.startButton.addTarget(self, action: #selector(self.startButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func startButtonClicked(_ sender:UIButton!) {
        print("start Button Clicked")
        let vector = self.calculateFirstDragonPosition()
        self.addNoEyedDragon(position: vector)
        self.gameView.startButton.removeFromSuperview()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)

    }
    
    @objc func updateTimer() {
          if (self.gameTime < 0.1) {
            timer.invalidate()
        //Send alert to indicate time's up.
            } else {
            self.gameTime -= 0.1
            self.gameView.timeLabel.text = String(format: "%.1f", self.gameTime)//self.gameTime)self.gameTime
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareSceneView()
    }
    
    func prepareSceneView() {
        self.gameView.sceneView.delegate = self
        self.gameView.sceneView.session.run(configuration)
        self.gameView.sceneView.autoenablesDefaultLighting = false
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.gameView.sceneView.addGestureRecognizer(gestureRecognizer)
        self.gameView.sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        self.gameView.sceneView.session.pause()
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let position = self.calculatePlayerPosition()//orientation + location
        let bullet = SCNNode(geometry: SCNSphere(radius: 0.1))
        bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        bullet.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bullet, options: nil))
        body.isAffectedByGravity = true
        bullet.physicsBody = body
        bullet.physicsBody?.applyForce(SCNVector3(orientation.x*power, orientation.y*power, orientation.z*power), asImpulse: true)
        bullet.physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
        bullet.physicsBody?.contactTestBitMask = BitMaskCategory.target.rawValue
        self.gameView.sceneView.scene.rootNode.addChildNode(bullet)
        bullet.runAction(
            SCNAction.sequence([SCNAction.wait(duration: 2.0),
                                SCNAction.removeFromParentNode()])
        )
    }
    
    func calculatePlayerPosition() -> SCNVector3 {
        let transform = self.gameView.sceneView.pointOfView!.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        return orientation + location
    }
    
    func calculateFirstDragonPosition() -> SCNVector3 {
        var position = self.calculatePlayerPosition()
        position.z -= 3
        return position
    }
    
    func calculateDragonPosition() -> SCNVector3 {
        var position = self.calculatePlayerPosition()
        position.z -=  Float.random(in: 3.0 ... 5.0)
        position.x -=  Float.random(in: -5.0 ... 5.0)
        position.y -=  Float.random(in: -5.0 ... 5.0)

        return position
    }
    
    func addNoEyedDragon(position: SCNVector3) {
        // let trexScene =  SCNScene(named: "art.scnassets/ship.scn")
        //  let trexNode = (trexScene?.rootNode.childNode(withName: "ship", recursively: false))!
        //  let trexScene =  SCNScene(named: "art.scnassets/dragonglare.scn")
        //  let trexNode = (trexScene?.rootNode.childNode(withName: "dragon", recursively: false))!
        //let trexScene =  SCNScene(named: "art.scnassets/egg.scn")
       // let trexNode = (trexScene?.rootNode.childNode(withName: "egg", recursively: false))!
        let dragonScene =  SCNScene(named: "art.scnassets/No_Eyed_Dragon.scn")
        let dragonNode = (dragonScene?.rootNode.childNode(withName: "No_Eyed_Dragon", recursively: false))!

        dragonNode.position = position//SCNVector3(x,y,z)
        dragonNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: dragonNode, options: nil))
        dragonNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        dragonNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        self.gameView.sceneView.scene.rootNode.addChildNode(dragonNode)
       // let dragonAction = rotation(time: 8)
         //let dragonAction = animate()
        //dragonNode.runAction(dragonAction)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if (nodeA.physicsBody?.categoryBitMask == nodeB.physicsBody?.categoryBitMask) {
            // edit animation
            return
        }
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeB
        }
        
        let deadEffectNode = self.makeDeadEffect(contact: contact)
        self.gameView.sceneView.scene.rootNode.addChildNode(deadEffectNode)
        self.Target?.removeFromParentNode()
        DispatchQueue.main.async {
            self.addNoEyedDragon(position: self.calculateDragonPosition())//(x: Float.random(in: -5.0 ... 5.0), y: Float.random(in: -5.0 ... 5.0), z: Float.random(in: -5.0 ... 5.0))
        }
        self.updateScore()
    }
    
    func makeDeadEffect(contact: SCNPhysicsContact) -> SCNNode {
        let effect = SCNParticleSystem(named: efectsArray[Int.random(in: 0 ... efectsArray.count-1)], inDirectory: nil)
        effect?.loops = false
        effect?.particleLifeSpan = 4
        effect?.emitterShape = SCNSphere(radius: 1)
        let effectNode = SCNNode()
        effectNode.addParticleSystem(effect!)
        effectNode.position = contact.contactPoint
        return effectNode
    }
    
    func updateScore() {
        DispatchQueue.main.async {
            self.score += 1
            self.gameView.scoreLabel.text = String(self.score)
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
    
    func rotation(time: TimeInterval) -> SCNAction {
       // guard let sceneView = sender.view as? ARSCNView else {return}
       // guard let pointOfView = self.sceneView.pointOfView else {return}
        let transform = self.gameView.sceneView.pointOfView!.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        let position = orientation + location
        let Rotation = SCNAction.rotate(by: CGFloat(360.degreesToRadians), around: position, duration: 1)//rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
       // let rr = SCNAction
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    
    func animate() -> SCNAction {
        //let moveIt = SCNAction.mov
        let moveUp = SCNAction.moveBy(x: 0, y: 1, z: 0, duration: 1)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.moveBy(x: 0, y: -1, z: 0, duration: 1)
        moveDown.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
       return moveLoop
    }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}


func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

