//
//  BarSnapshotsScene.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

class BarSnapshotsScene: PlayableScene {
    
    //flag to count photos matched
    var clicked = 0
    
    var choice: String = ""
    
    var firstCutscene: String = ""
    
    private var overlayNode: SKSpriteNode!
    
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
            selectedScene = "memory-3c-s1"
            break
        case 3:
            previousScene = "memory-3c-s1"
            selectedScene = "memory-3c-s2"
            break
        default:
            break
        }
        if selectedScene != "" {
            self.childNode(withName: previousScene)?.alpha = 0
            self.childNode(withName: selectedScene)?.alpha = 1
            if selectedScene == "memory-3b" {
                self.sceneManager?.presentCrashQTEScene()
            }
            if selectedScene == "memory-3c-s2" {
//                self.childNode(withName: "keep-button")?.alpha = 1
//                self.childNode(withName: "burn-button")?.alpha = 1
//                self.childNode(withName: "tap-label")?.alpha = 0
            }
        }
    }
    
    override func didMove(to view: SKView) {
        setupDialogBox()
        
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
}



