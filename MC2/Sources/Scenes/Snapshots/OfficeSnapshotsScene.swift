//
//  OfficeSnapshotsScene.swift
//  MC2
//
//  Created by Ivan on 01/07/23.
//

import Foundation
import GameplayKit


class OfficeSnapshotsScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
    weak var gameState: GameState?
    
    var memoryNodes: [SKSpriteNode]!
    
    /** tap contnue label node */
    var tapContinueLabel: SKLabelNode!
    
    /** Track current snapshot that already seen */
    var currentSnapshotIndex: Int = 0
    
    var touchEventsEnabled: Bool = false
    
    let fadeDuration: TimeInterval = 1.0
    
    let delayDuration: TimeInterval = 2.0
    
    /** show snapshot and its tap continue */
    func animateShowingSnapshot(for node: SKSpriteNode, isShowTapContinue: Bool = true) {
        let delayedTapContinueDuration = delayDuration + 2
        let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
        _ = SKAction.run { self.touchEventsEnabled = true }
        
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        node.run(snapshotSequence)
        
        if isShowTapContinue {
            let tapContinueSequence = SKAction.sequence([
                SKAction.wait(forDuration: delayedTapContinueDuration),
                fadeInAction,
                SKAction.run { self.touchEventsEnabled = true }
            ])
            
            tapContinueLabel.run(tapContinueSequence)
        } else {
            self.touchEventsEnabled = true
        }
    }
    
    /** hide snapshot and its tap continue */
    func animateHidingSnapshot(for node: SKSpriteNode) {
        let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
        let fadeOutTapAction = SKAction.group([
            fadeOutAction,
            SKAction.run {
                self.touchEventsEnabled = false
            }
        ])
                
        node.run(fadeOutAction)
        tapContinueLabel.run(fadeOutTapAction)
    }
    
    /** Inject tap to continue label on the bottom-right of corner */
    func createTapContinueLabel() {
        tapContinueLabel = SKLabelNode(fontNamed: Constants.fontName)
        tapContinueLabel.text = "Tap to continue"
        tapContinueLabel.name = "tap-label"
        tapContinueLabel.fontSize = 40
        tapContinueLabel.fontColor = .black
        tapContinueLabel.position = CGPoint(x: frame.maxX - (40 * 4), y: frame.minY + 40)
        tapContinueLabel.zPosition = 10
        tapContinueLabel.alpha = 0
        addChild(tapContinueLabel)
    }
}

// MARK: Overrided methods.
extension OfficeSnapshotsScene {
        
    override func didMove(to view: SKView) {
        memoryNodes = childNode(withName: "MemoryNodes")!.children as? [SKSpriteNode]
        
        createTapContinueLabel()
        
        animateShowingSnapshot(for: memoryNodes[0])
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {        
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else {
            return
        }
        
        if currentSnapshotIndex < memoryNodes.count - 1 {
            let currentSnapshotNode = memoryNodes[currentSnapshotIndex]
            let nextSnapshotNode = memoryNodes[currentSnapshotIndex + 1]
            
            currentSnapshotIndex += 1
            let isLastSnapshot = currentSnapshotIndex < memoryNodes.count - 1
            
            animateHidingSnapshot(for: currentSnapshotNode)
            animateShowingSnapshot(for: nextSnapshotNode, isShowTapContinue: isLastSnapshot)
        } else {
            let touchedLocation = touch.location(in: self)
            if let touchedNode = self.nodes(at: touchedLocation).first {
            
                switch(touchedNode.name) {
                case Constants.acceptNode:
                    // Doing action if accepting the phone.
                    gameState?.setState(key: .momsCallAccepted, value: .boolValue(true))
                    let whiteFade = SKTransition.fade(with: .white, duration: 1)
                    sceneManager?.presentOfficeRoomScene(
                        playerPosition: .computerSpot,
                        transition: whiteFade
                    )
                case Constants.declineNode:
                    // Doing action if decline the phone.
                    gameState?.setState(key: .momsCallAccepted, value: .boolValue(false))
                    let whiteFade = SKTransition.fade(with: .white, duration: 1)
                    sceneManager?.presentOfficeRoomScene(
                        playerPosition: .computerSpot,
                        transition: whiteFade
                    )
                default:
                    break
                }
            }
        }
    }
}
