//
//  BedroomSnapshotsScene.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

class BedroomSnapshotsScene: PlayableScene {
    
    //flag to count photos matched
    var clicked = 0
    
    var photoPicked: String = ""
    
    private var overlayNode: SKSpriteNode!
    
    override func update(_ currentTime: TimeInterval) {
        var previousScene = ""
        var selectedScene = ""
        switch clicked {
        case 1:
            previousScene = "memory-2a"
            selectedScene = "memory-2b"
            break
        case 2:
            previousScene = "memory-2b"
            selectedScene = "memory-2c"
            break
        case 3:
            previousScene = "memory-2c"
            selectedScene = "memory-2d"
            break
        default:
            break
        }
        if selectedScene != "" {
            self.childNode(withName: previousScene)?.alpha = 0
            self.childNode(withName: selectedScene)?.alpha = 1
            if selectedScene == "memory-2d" {
                self.childNode(withName: "keep-button")?.alpha = 1
                self.childNode(withName: "burn-button")?.alpha = 1
                self.childNode(withName: "tap-label")?.alpha = 0
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
        let touchedNode = self.nodes(at: touchLocation).first
        
        if clicked < 3 {
            // Animate the fade effect
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            overlayNode.run(SKAction.sequence([fadeInAction, fadeOutAction]))
            timeout(after: 0.5, node: self) {
                self.clicked += 1
            }
        }
        
        if touchedNode?.name == "burn-button" {
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt2_seq2
            ], from: self)
            timeout(after: 6.0, node: self) {
                // This code will be executed after 5 seconds
                self.sceneManager?.presentBedroomScene()
            }
        }
        
        if touchedNode?.name == "keep-button" {
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt1_seq1
            ], from: self)
            timeout(after: 6.0, node: self) {
                // This code will be executed after 5 seconds
                self.sceneManager?.presentBedroomTidyScene()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
//    func timeout(after seconds: TimeInterval, node: SKNode, completion: @escaping () -> Void) {
//        let waitAction = SKAction.wait(forDuration: seconds)
//        let completionAction = SKAction.run(completion)
//        let sequenceAction = SKAction.sequence([waitAction, completionAction])
//        node.run(sequenceAction)
//    }
    
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
}

