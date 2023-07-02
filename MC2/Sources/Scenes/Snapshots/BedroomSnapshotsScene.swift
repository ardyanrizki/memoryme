//
//  BedroomSnapshotsScene.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

extension Constants {
    static let secondMemoryA = "memory-2a"
    static let secondMemoryB = "memory-2b"
    static let secondMemoryC = "memory-2c"
    static let secondMemoryD = "memory-2d"
    static let keepButton = "keep-button"
    static let burnButton = "burn-button"
    static let tapLabel = "tap-label"
    static let tapToContinue = "Tap to continue"
}

class BedroomSnapshotsScene: PlayableScene {
    
    // Flag to count photos matched.
    var pageIndex = 0
    
    var photoPicked: String = .emptyString
    
    private var overlayNode: SKSpriteNode!
    
    override func update(_ currentTime: TimeInterval) {
        var previousScene: String = .emptyString
        var selectedScene: String = .emptyString
        switch pageIndex {
        case 1:
            previousScene = Constants.secondMemoryA
            selectedScene = Constants.secondMemoryB
            break
        case 2:
            previousScene = Constants.secondMemoryB
            selectedScene = Constants.secondMemoryC
            break
        case 3:
            previousScene = Constants.secondMemoryC
            selectedScene = Constants.secondMemoryD
            break
        default:
            break
        }
        if selectedScene != .emptyString {
            self.childNode(withName: previousScene)?.alpha = 0
            self.childNode(withName: selectedScene)?.alpha = 1
            if selectedScene == Constants.secondMemoryD {
                self.childNode(withName: Constants.keepButton)?.alpha = 1
                self.childNode(withName: Constants.burnButton)?.alpha = 1
                self.childNode(withName: Constants.tapLabel)?.alpha = 0
            }
        }
    }
    
    override func didMove(to view: SKView) {
        setupDialogBox()
        addPromptLabelToScene()
        addOverlayToScene()
    }
    
    func addPromptLabelToScene() {
        let promptLabel = SKLabelNode(fontNamed: Constants.fontName)
        promptLabel.text = Constants.tapToContinue
        promptLabel.name = Constants.tapLabel
        promptLabel.fontSize = 40
        promptLabel.fontColor = .black
        promptLabel.position = CGPoint(x: frame.maxX - 250, y: (frame.minY + 50))
        promptLabel.horizontalAlignmentMode = .left
        promptLabel.zPosition = 100
        self.addChild(promptLabel)
    }
    
    func addOverlayToScene() {
        overlayNode = SKSpriteNode(color: UIColor.black.withAlphaComponent(0.5), size: frame.size)
        overlayNode.position = CGPoint(x: frame.midX, y: frame.midY)
        overlayNode.zPosition = 100 // Place the overlay above other nodes.
        overlayNode.alpha = 0 // Initially hidden.
        self.addChild(overlayNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if pageIndex < 3 {
            // Animate the fade effect.
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            overlayNode.run(SKAction.sequence([fadeInAction, fadeOutAction]))
            timeout(after: 0.5, node: self) {
                self.pageIndex += 1
            }
        }
        
        if touchedNode?.name == Constants.burnButton {
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt2_seq2
            ], from: self)
            timeout(after: 6.0, node: self) {
                // This code will be executed after 5 seconds.
                self.gameState?.setState(key: .friendsPhotosKept, value: .boolValue(false))
                self.sceneManager?.presentBedroomScene(playerPosition: .photoAlbumSpot)
            }
        }
        
        if touchedNode?.name == Constants.keepButton {
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt1_seq1
            ], from: self)
            timeout(after: 6.0, node: self) {
                // This code will be executed after 5 seconds.
                self.gameState?.setState(key: .friendsPhotosKept, value: .boolValue(true))
                self.sceneManager?.presentBedroomScene(playerPosition: .bedroomCenter)
            }
        }
    }
    
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
}


