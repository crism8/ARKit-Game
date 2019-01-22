//
//  ViewController.swift
//  ARKitGame
//
//  Created by Cristrian Makarski on 29/10/2018.
//  Copyright © 2018 Cristrian Makarski. All rights reserved.
//

import UIKit
import ARKit

enum BitMaskCategory: Int {
    case bullet = 2
    case target = 3
}

class GameViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate {
    let configuration = ARWorldTrackingConfiguration()
    let easyScoreLimit = 5
    let mediumScoreLimit = 10
    let hardScoreLimit = 20

    let efectsArray = ["art.scnassets/Smoke.scnp", "art.scnassets/Bokeh.scnp", "art.scnassets/Fire.scnp", "art.scnassets/Reactor.scnp", "art.scnassets/Confetti.scnp"]
    var power: Float
    var Target: SCNNode?
    var score: Int = 0
    var dragonNode: SCNNode?
    var playerName: String

    let gameView = GameView()
    let pauseView = PausedGameView()
    let endGameView = EndGameView()

    var timer = Timer()
    var gameTime = 45.0
    
    init(playerName: String) {
        self.power = 30
        self.playerName = playerName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gameView
        self.gameView.timeLabel.text = String(format: "%.1f", self.gameTime)
        self.setupPauseView()
        self.setTargetsForButtons()
        self.setupEndGameView()
    }
    
    func setupPauseView() {
        self.view.addSubview(self.pauseView)
        self.pauseView.pinAllEdges(to: self.view)
    }
    
    func setupEndGameView() {
        self.view.addSubview(self.endGameView)
        self.endGameView.pinAllEdges(to: self.view)
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
        self.pauseView.isHidden = false
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
    //    let location = SCNVector3(transform.m41, transform.m42, transform.m43)
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
        let dragonScene =  SCNScene(named: "art.scnassets/No_Eyed_Dragon.scn")
        let dragonNode = (dragonScene?.rootNode.childNode(withName: "No_Eyed_Dragon", recursively: false))!
        dragonNode.position = position
        dragonNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: dragonNode, options: nil))
        dragonNode.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
        dragonNode.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue
        self.dragonNode = dragonNode
        self.gameView.sceneView.scene.rootNode.addChildNode(dragonNode)
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        
        if nodeA.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.Target = nodeB
        }
        
        let deadEffectNode = self.makeDeadEffect(contact: contact)
        self.gameView.sceneView.scene.rootNode.addChildNode(deadEffectNode)
        self.Target?.removeFromParentNode()
        self.performAfterDragonDeath()
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
    
    func performAfterDragonDeath() {
        
        DispatchQueue.main.async {
            self.gameTime += 3.0
            self.addNoEyedDragon(position: self.calculateDragonPosition())
            self.updateScore()
            if (self.score > self.hardScoreLimit) {
                self.dragonNode?.runAction(self.animateHard())
            } else if (self.score > self.mediumScoreLimit){
                self.dragonNode?.runAction(self.animateMedium())
            } else if (self.score > self.easyScoreLimit) {
                self.dragonNode?.runAction(self.animateEasy())
            }
        }
    }
    
    func updateScore() {
        self.score += 1
        self.gameView.scoreLabel.text = String(self.score)
    }
    
    func animateEasy() -> SCNAction {
        let moveUp = SCNAction.moveBy(x: 0, y: 1.5, z: 0, duration: 1.5)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.moveBy(x: 0, y: -1.5, z: 0, duration: 1.5)
        moveDown.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp,moveDown])
        let moveLoop = SCNAction.repeatForever(moveSequence)
       return moveLoop
    }
    
    func animateMedium() -> SCNAction {
        let moveUp = SCNAction.moveBy(x: 0, y: 2, z: 0, duration: 1)
        moveUp.timingMode = .easeInEaseOut;
        let moveDown = SCNAction.moveBy(x: 0, y: -2, z: 0, duration: 1)
        moveDown.timingMode = .easeInEaseOut;
        let moveOneSide = SCNAction.moveBy(x: 2, y: 0, z: 0, duration: 1)
        moveOneSide.timingMode = .easeInEaseOut;
        let moveOtherSide = SCNAction.moveBy(x: -2, y: 0, z: 0, duration: 1)
        moveOtherSide.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([moveUp ,moveOneSide, moveDown, moveOtherSide])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        return moveLoop
    }
    
    func animateHard() -> SCNAction {
        let move1 = SCNAction.moveBy(x: 2, y: 2, z: 0, duration: 0.5)
        move1.timingMode = .easeInEaseOut;
        let move2 = SCNAction.moveBy(x: -2, y: -2, z: 0, duration: 0.5)
        move2.timingMode = .easeInEaseOut;
        let moveSequence = SCNAction.sequence([move1,move2])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        return moveLoop
    }
    
    // Mark: Setting Targets
    func setTargetsForButtons() {
        self.gameView.startButton.addTarget(self, action: #selector(self.startButtonClicked(_:)), for: .touchUpInside)
        self.gameView.pauseButton.addTarget(self, action: #selector(self.pauseButtonClicked(_:)), for: .touchUpInside)
        
        self.pauseView.resumeButton.addTarget(self, action: #selector(self.resumeButtonClicked(_:)), for: .touchUpInside)
        self.pauseView.restartButton.addTarget(self, action: #selector(self.restartButtonClicked(_:)), for: .touchUpInside)
        self.pauseView.quitButton.addTarget(self, action: #selector(self.quitButtonClicked(_:)), for: .touchUpInside)
        
        self.endGameView.restartButton.addTarget(self, action: #selector(self.restartButtonClicked(_:)), for: .touchUpInside)
        self.endGameView.quitButton.addTarget(self, action: #selector(self.quitButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func startButtonClicked(_ sender:UIButton!) {
        let vector = self.calculateFirstDragonPosition()
        self.addNoEyedDragon(position: vector)
        self.gameView.startButton.removeFromSuperview()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        self.gameView.pauseButton.isHidden = false
    }
    
    @objc func updateTimer() {
        if (self.gameTime < 0.1) {
            self.actionForGameEnd()
        } else {
            self.gameTime -= 0.1
            self.gameView.timeLabel.text = String(format: "%.1f", self.gameTime)
        }
    }
    
    func actionForGameEnd() {
        self.gameView.timeLabel.text = "0.0"
        timer.invalidate()
        self.endGameView.playerNameLabel.text = self.playerName
        self.endGameView.scoreLabel.text = String(score)
        self.endGameView.isHidden = false
        self.gameView.gunSight.isHidden = true
        self.sendScoreToFirebase()
    }
    
    func sendScoreToFirebase() {
        let firebase = FirebaseServices.init()
        let dict = ["playerName": self.playerName, "score": String(self.score)]
        firebase.sendScore(dict: dict as NSDictionary)
    }
    
    @objc func pauseButtonClicked(_ sender:UIButton!) {
        self.pauseView.isHidden = false
        timer.invalidate()
    }
    
    @objc func resumeButtonClicked(_ sender:UIButton!) {
        self.pauseView.isHidden = true
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func restartButtonClicked(_ sender:UIButton!) {
        self.gameView.gunSight.isHidden = false
        self.pauseView.isHidden = true
        self.gameTime = 60
        self.gameView.timeLabel.text = String(format: "%.1f", self.gameTime)
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func quitButtonClicked(_ sender:UIButton!) {
       self.dismiss(animated: true, completion: nil)
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

