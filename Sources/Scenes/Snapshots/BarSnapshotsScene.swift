//
//  BarSnapshotsScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

class BarSnapshotsScene: PlayableScene {
    
    //flag to count photos matched
    var clicked = 0
    
    var choice: String = ""
    
    /** tap contnue label node */
    var tapContinueLabel: SKLabelNode!
    
    /** Track current snapshot that already seen */
    var currentSnapshotIndex: Int = 0
    
    let fadeDuration: TimeInterval = 1.0
    
    let delayDuration: TimeInterval = 2.0
    
    private var overlayNode: SKSpriteNode!
    
    weak var gameViewController: GameViewController?
    var truckSFX = SoundComponent(soundFile: Constants.truck)
    var cutSceneBar = SoundComponent(soundFile: Constants.cutSceneBar)
    
    /** show snapshot and its tap continue */
    func animateShowingSnapshot(for node: SKSpriteNode) {
        let delayedTapContinueDuration = delayDuration + 2
        let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
        let touchEnabledAction = SKAction.run { self.touchEventsEnabled = true }
        
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        node.run(snapshotSequence)
        
        let tapContinueSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayedTapContinueDuration),
            fadeInAction,
            SKAction.run { self.touchEventsEnabled = true }
        ])
        
        tapContinueLabel.run(tapContinueSequence)
    }
    
    /** hide snapshot and its tap continue */
    func animateHidingSnapshot(for node: SKSpriteNode, completion: @escaping () -> Void = {}) {
        let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
        let fadeOutTapAction = SKAction.group([
            fadeOutAction,
            SKAction.run {
                self.touchEventsEnabled = false
                completion()
            }
        ])
                
        node.run(fadeOutAction)
        tapContinueLabel.run(fadeOutTapAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        var previousScene = ""
        var selectedScene = ""
        switch clicked {
        case 1:
            previousScene = "memory-3a"
            selectedScene = "memory-3b"
            break
        case 2:
            previousScene = "memory-3b"
            selectedScene = self.choice == "fail" ? "memory-3d-d1" : "memory-3c-s1"
            break
        case 3:
            previousScene = self.choice == "fail" ? "memory-3d-d1" : "memory-3c-s1"
            selectedScene = self.choice == "fail" ? "memory-3d-d2" : "memory-3c-s2"
            break
        default:
            break
        }
        if selectedScene != "" {
            self.childNode(withName: previousScene)?.alpha = 0
            self.childNode(withName: selectedScene)?.alpha = 1
            if selectedScene == "memory-3b" {
                self.sceneManager?.presentCrashQTEScene()
                
                self.truckSFX.soundPlayer?.play()
                self.truckSFX.soundPlayer?.volume = 0.4
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        //Cut off sound
        gameViewController?.stopBackgroundMusic()
        
        gameViewController?.playBackgroundMusic(filename: Constants.cutSceneBar)
        
        setupDialogBox()
        playBackgroundMusic(filename: Constants.cutsceneBar)
        if choice != "" {
            let initScene = "memory-3a"
            let selectedScene = self.choice == "fail" ? "memory-3d-d1" : "memory-3c-s1"
            self.childNode(withName: initScene)?.alpha = 0
            self.childNode(withName: selectedScene)?.alpha = 1
            clicked = 2
        }
        
        let promptLabel = SKLabelNode(fontNamed: Constants.fontName)
        promptLabel.text = "Tap to continue"
        promptLabel.name = "tap-label"
        promptLabel.fontSize = 40
        promptLabel.fontColor = .black
        promptLabel.position = CGPoint(x: frame.maxX - 250, y: (frame.minY + 50))
        promptLabel.horizontalAlignmentMode = .left
        promptLabel.zPosition = 100
        self.addChild(promptLabel)
        
        // Create the overlay node with the size of the scene
        overlayNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: frame.size)
        overlayNode.position = CGPoint(x: frame.midX, y: frame.midY)
        overlayNode.zPosition = 100 // Place the overlay above other nodes
        overlayNode.alpha = 0 // Initially hidden
        self.addChild(overlayNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        let _ = self.nodes(at: touchLocation).first
        
        if clicked < 3 {
            // Animate the fade effect
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            overlayNode.run(SKAction.sequence([fadeInAction, fadeOutAction]))
            timeout(after: 0.5, node: self) {
                self.clicked += 1
            }
        } else {
            self.stopBackgroundMusic()
            self.sceneManager?.presentBarScene(playerPosition: .barAfterMiniGameEntrance, transition: SKTransition.fade(withDuration: 0.5))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
    
    override func willMove(from view: SKView) {
        gameViewController?.stopBackgroundMusic()
    }
}



