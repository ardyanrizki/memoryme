//
//  BarSnapshotsScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit

class BarSnapshotsScene: SnapshotsScene {
    
    // MARK: - Scene Lifecycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        playSnapshotAudio()
        
        if let gameStateManager, gameStateManager.stateExisted(.strangerSaved) {
            handleStrangerSavedSnapshot()
        } else {
            Task {
                await showSnapshot(forIndex: 0)
            }
        }
    }
    
    // MARK: - Snapshot Audio
    
    func playSnapshotAudio() {
        audioPlayerManager?.play(audioFile: .barSnapshotsBGM, type: .background, volume: 0.2)
    }
    
    // MARK: - Snapshot Handling
    
    private func handleStrangerSavedSnapshot() {
        let isStrangerSaved = gameStateManager?.getState(key: .strangerSaved) == .boolValue(true)
        let fileNameToRemove = isStrangerSaved ? "failed" : "saved"
        removeSnapshotNodes(withNameContaining: fileNameToRemove)
        
        Task {
            await showSnapshot(forIndex: 2)
        }
    }
    
    private func removeSnapshotNodes(withNameContaining name: String) {
        snapshotNodes.removeAll { node in
            node.name?.contains(name) ?? false
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        switch currentSnapshotIndex {
        case 1:
            presentCrashQTEScene()
        default:
            handleNextSnapshotOrSceneTransition()
        }
    }
    
    private func presentCrashQTEScene() {
        scenePresenter?.presentCrashQTEMiniGame()
    }
    
    private func handleNextSnapshotOrSceneTransition() {
        Task {
            await hideAndShowNextSnapshot()
            
            if isLastSnapshot() {
                handleLastSnapshot()
            }
        }
    }
    
    private func hideAndShowNextSnapshot() async {
        await hideSnapshot()
        showNextSnapshotIfNeeded()
    }
    
    private func showNextSnapshotIfNeeded() {
        guard currentSnapshotIndex < snapshotNodes.count - 1 else { return }
        
        Task {
            await showSnapshot()
        }
    }
    
    private func isLastSnapshot() -> Bool {
        return currentSnapshotIndex == snapshotNodes.count - 1
    }
    
    private func handleLastSnapshot() {
        audioPlayerManager?.stop(audioFile: .barSnapshotsBGM)
        presentNextScene()
    }
    
    private func presentNextScene() {
        let whiteFade = SKTransition.fade(with: .white, duration: 1)
        scenePresenter?.presentBar(playerPosition: .barRadioSpot, transition: whiteFade)
    }
}
