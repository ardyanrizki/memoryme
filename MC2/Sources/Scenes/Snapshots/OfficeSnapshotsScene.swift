//
//  OfficeCutScene.swift
//  MC2
//
//  Created by Ivan on 01/07/23.
//

import Foundation
import GameplayKit


class OfficeSnapshotsScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
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
        let touchEnabledAction = SKAction.run { self.touchEventsEnabled = true }
        
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        node.run(snapshotSequence)
        
        if isShowTapContinue {
            let tapContinueSequence = SKAction.sequence([
                SKAction.wait(forDuration: delayedTapContinueDuration),
                fadeInAction,
                touchEnabledAction
            ])
            
            tapContinueLabel.run(tapContinueSequence)
        } else {
            tapContinueLabel.run(touchEnabledAction)
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
        
        currentSnapshotIndex = 0
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
            let momCalledSnapshotNode = memoryNodes[currentSnapshotIndex]
            
            for answerNode in momCalledSnapshotNode.children {
                if answerNode.contains(touchedLocation) {
                    // TODO
                }
            }
        }
    }
}
