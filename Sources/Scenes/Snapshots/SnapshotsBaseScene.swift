//
//  SnapshotsBaseScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 10/07/23.
//

import SpriteKit
import GameplayKit

class SnapshotsBaseScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
    weak var audioPlayerManager: AudioPlayerManager?
    
    weak var gameState: GameState?
    
    var snapshots = [SKSpriteNode]()
    
    var snapshotIndex: Int = 0
    
    var touchEventsEnabled: Bool = false
    
    let fadeDuration: TimeInterval = 1.0
    
    let delayDuration: TimeInterval = 2.0
    
    var tapToContinueLabel: SKLabelNode!
    
    var dialogBox: DialogBoxNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSnapshotNodes()
        setupContinueLabel()
        setupDialogBox()
    }
    
    func setupSnapshotNodes() {
        guard let allSnapshotNodes = childNode(withName: "SnapshotNodes")?.children as? [SKSpriteNode] else { return }
        allSnapshotNodes.forEach { $0.alpha = 0.0 }
        snapshots = allSnapshotNodes
    }
    
    func setupDialogBox() {
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
    
    func setupContinueLabel() {
        tapToContinueLabel = SKLabelNode(fontNamed: Constants.fontName)
        tapToContinueLabel.text = "Tap to continue"
        tapToContinueLabel.name = "tap-label"
        tapToContinueLabel.fontSize = 40
        tapToContinueLabel.fontColor = .black
        tapToContinueLabel.position = CGPoint(x: frame.maxX - (40 * 4), y: frame.minY + 40)
        tapToContinueLabel.zPosition = 10
        tapToContinueLabel.alpha = 0
        addChild(tapToContinueLabel)
    }
}

extension SnapshotsBaseScene {
    
    // Show snapshot and its tap continue
    func showSnapshot(forIndex index: Int, completion: @escaping () -> Void) {
        guard index < snapshots.count else { return }
        snapshotIndex = index
        
        let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        snapshots[index].run(snapshotSequence) {
            completion()
        }
        
        if index < snapshots.count - 1 {
            let tapContinueSequence = SKAction.sequence([
                SKAction.wait(forDuration: delayDuration + 2),
                fadeInAction,
                SKAction.run { self.touchEventsEnabled = true }
            ])
            
            tapToContinueLabel.run(tapContinueSequence)
        } else {
            self.touchEventsEnabled = true
        }
    }
    
    // Hide snapshot and its tap continue
    func hideSnapshot(forIndex index: Int, completion: @escaping () -> Void) {
        guard index < snapshots.count else { return }
        
        let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
        let fadeOutTapAction = SKAction.group([
            fadeOutAction,
            SKAction.run {
                self.touchEventsEnabled = false
                completion()
            }
        ])
                
        snapshots[index].run(fadeOutAction)
        tapToContinueLabel.run(fadeOutTapAction)
    }
}
