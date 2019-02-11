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
    
    let bulletRadius: CGFloat = 0.1
    let bulletLifeTime = 2.0
    
    let firstDragonZPostion: Float = 3.0
    let nextDragonZPosition: ClosedRange<Float> = 3.0 ... 5.0
    let nextDragonXPosition: ClosedRange<Float> = -5.0...5
    let nextDragonYPosition: ClosedRange<Float> = -5.0...5
    let dragonSceneName = "art.scnassets/No_Eyed_Dragon.scn"
    let dragonNodeName = "No_Eyed_Dragon"
    
    let effectsArray = ["art.scnassets/Smoke.scnp", "art.scnassets/Bokeh.scnp", "art.scnassets/Fire.scnp", "art.scnassets/Reactor.scnp", "art.scnassets/Confetti.scnp"]
    let effectsParticleLifeSpan: CGFloat = 4.0
    let effectRadius: CGFloat = 1.0

    let bonusTime = 3.0
    let power: Float = 30.0
    var targetNode: SCNNode?
    var score: Int = 0
    var dragonNode: SCNNode?
    var playerName: String

    let gameView = GameView()
    let pauseView = PausedGameView()
    let endGameView = EndGameView()

    var timer = Timer()
    let startGameTime = 45.0
    var currentGameTime: Double
    
    init(playerName: String) {
        self.playerName = playerName
        self.currentGameTime = self.startGameTime
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = gameView
        self.gameView.timeLabel.text = String(format: "%.1f", self.currentGameTime)
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
        self.gameView.sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.gameView.sceneView.session.pause()
        self.pauseView.isHidden = false
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        guard let sceneView = sender.view as? ARSCNView else {return}
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let position = self.calculatePlayerPosition()
        let bullet = SCNNode(geometry: SCNSphere(radius: self.bulletRadius))
        bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        bullet.position = position
        let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: bullet, options: nil))
        body.isAffectedByGravity = true
        bullet.physicsBody = body
        bullet.physicsBody?.applyForce(SCNVector3(orientation.x*self.power, orientation.y*self.power, orientation.z*self.power), asImpulse: true)
        bullet.physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
        bullet.physicsBody?.contactTestBitMask = BitMaskCategory.target.rawValue
        self.gameView.sceneView.scene.rootNode.addChildNode(bullet)
        bullet.runAction(
            SCNAction.sequence([SCNAction.wait(duration: self.bulletLifeTime),
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
        position.z -= self.firstDragonZPostion
        return position
    }
    
    func calculateDragonPosition() -> SCNVector3 {
        var position = self.calculatePlayerPosition()
        position.z -=  Float.random(in: self.nextDragonZPosition)
        position.x -=  Float.random(in: self.nextDragonXPosition)
        position.y -=  Float.random(in: self.nextDragonYPosition)

        return position
    }
    
    func addNoEyedDragon(position: SCNVector3) {
        let dragonScene =  SCNScene(named: self.dragonSceneName)
        let dragonNode = (dragonScene?.rootNode.childNode(withName: self.dragonNodeName, recursively: false))!
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
            self.targetNode = nodeA
        } else if nodeB.physicsBody?.categoryBitMask == BitMaskCategory.target.rawValue {
            self.targetNode = nodeB
        }
        
        let deadEffectNode = self.makeDeadEffect(contact: contact)
        self.gameView.sceneView.scene.rootNode.addChildNode(deadEffectNode)
        self.targetNode?.removeFromParentNode()
        self.performAfterDragonDeath()
    }
    
    func makeDeadEffect(contact: SCNPhysicsContact) -> SCNNode {
        let effect = SCNParticleSystem(named: effectsArray[Int.random(in: 0 ... effectsArray.count-1)], inDirectory: nil)
        effect?.loops = false
        effect?.particleLifeSpan = self.effectsParticleLifeSpan
        effect?.emitterShape = SCNSphere(radius: self.effectRadius)
        let effectNode = SCNNode()
        effectNode.addParticleSystem(effect!)
        effectNode.position = contact.contactPoint
        return effectNode
    }
    
    func performAfterDragonDeath() {
        DispatchQueue.main.async {
            self.currentGameTime += self.bonusTime
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
        var moves = Array<SCNAction>()
        for _ in 0...5 {
        let cgf =  CGFloat.random(in: 1.0 ... 4.0)
        let move = SCNAction.moveBy(x: cgf, y: cgf, z: 0, duration: 0.5)
        moves.append(move)
        }
      
        let moveSequence = SCNAction.sequence(moves)
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
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.gameView.sceneView.addGestureRecognizer(gestureRecognizer)
        let vector = self.calculateFirstDragonPosition()
        self.addNoEyedDragon(position: vector)
        self.gameView.startButton.removeFromSuperview()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        self.gameView.pauseButton.isHidden = false
    }
    
    @objc func updateTimer() {
        if (self.currentGameTime < 0.1) {
            self.actionForGameEnd()
        } else {
            self.currentGameTime -= 0.1
            self.gameView.timeLabel.text = String(format: "%.1f", self.currentGameTime)
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
        self.currentGameTime =  self.startGameTime
        self.gameView.timeLabel.text = String(format: "%.1f", self.currentGameTime)
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func quitButtonClicked(_ sender:UIButton!) {
       self.dismiss(animated: true, completion: nil)
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

