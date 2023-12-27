//
//  SnapshotsScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 10/07/23.
//

import SpriteKit

/// A scene to display snapshots with interactive features.
class SnapshotsScene: PlayableScene {
    
    // MARK: - Properties
    
    /// An array to store snapshot nodes.
    var snapshotNodes = [SKSpriteNode]()
    
    /// The current index of the displayed snapshot.
    var currentSnapshotIndex: Int = 0
    
    /// A flag indicating whether touch events are enabled.
    var touchEventsEnabled: Bool = false
    
    /// The duration for fading in/out snapshots.
    let fadeDuration: TimeInterval = 1.0
    
    /// The duration to wait before displaying the next snapshot.
    let delayDuration: TimeInterval = 1.4
    
    /// The label to prompt users to tap to continue.
    var tapToContinueLabel: SKLabelNode!
    
    var isLastSnapshot: Bool {
        currentSnapshotIndex == snapshotNodes.count - 1
    }
    
    // MARK: - Scene Setup
    
    override func setup(scenePresenter: ScenePresenter?, audioPlayerManager: AudioPlayerManager?, gameStateManager: GameStateManager?) {
        super.setup(scenePresenter: scenePresenter, audioPlayerManager: audioPlayerManager, gameStateManager: gameStateManager)
        self.audioPlayerManager?.stop(audioFile: .ambience)
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSnapshotNodes()
        setupContinueLabel()
        setupDialogBox()
    }
    
    // MARK: - Helper Methods
    
    /// Configures the snapshot nodes from the child nodes of the "SnapshotNodes" group.
    private func setupSnapshotNodes() {
        guard let allSnapshotNodes = childNode(withName: "SnapshotNodes")?.children as? [SKSpriteNode] else { return }
        allSnapshotNodes.forEach { $0.alpha = 0.0 }
        snapshotNodes = allSnapshotNodes
    }
    
    /// Configures and adds the tap to continue label to the scene.
    private func setupContinueLabel() {
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
    
    // MARK: - Snapshot Handling
    
    /// Show snapshot for the specified index and invoke the completion handler when done.
    ///
    /// - Parameters:
    ///   - index: The index of the snapshot to show.
    func showSnapshot(forIndex index: Int? = nil) async {
        var nextIndex = currentSnapshotIndex + 1
        
        if let index {
            nextIndex = index
        }
        
        guard nextIndex < snapshotNodes.count else { return }
        
        currentSnapshotIndex = nextIndex
        
        let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        await withCheckedContinuation { continuation in
            snapshotNodes[currentSnapshotIndex].run(snapshotSequence) {
                continuation.resume()
            }
        }
        
        if nextIndex <= snapshotNodes.count - 1 {
            guard (snapshotNodes[nextIndex].name?.contains("wait-action")) == false else {
                touchEventsEnabled = true
                return
            }
            let tapContinueSequence = SKAction.sequence([
                SKAction.wait(forDuration: delayDuration + 2),
                fadeInAction,
                SKAction.run { self.touchEventsEnabled = true }
            ])
            
            await tapToContinueLabel.run(tapContinueSequence)
        } else {
            touchEventsEnabled = true
        }
    }
    
    /// Hide snapshot for the specified index and invoke the completion handler when done.
    func hideSnapshot() async {
        guard currentSnapshotIndex < snapshotNodes.count else { return }
        await withCheckedContinuation { continuation in
            let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
            let fadeOutTapAction = SKAction.group([
                fadeOutAction,
                SKAction.run {
                    self.touchEventsEnabled = false
                    continuation.resume()
                }
            ])
            
            snapshotNodes[currentSnapshotIndex].run(fadeOutAction)
            tapToContinueLabel.run(fadeOutTapAction)
        }
    }
}
