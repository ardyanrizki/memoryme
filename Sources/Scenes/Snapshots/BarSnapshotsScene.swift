//
//  BarSnapshotsScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

class BarSnapshotsScene: SnapshotsBaseScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        audioPlayerManager?.add(fileName: .barSnapshotsBGM)
        playSnapshotAudio()
        
        if let gameState, gameState.stateExisted(.strangerSaved) {
            let isStrangerSaved = gameState.getState(key: .strangerSaved) == .boolValue(true)
            let fileNameToRemove = isStrangerSaved ? "failed" : "saved"
            snapshots.removeAll { node in
                node.name?.contains(fileNameToRemove) ?? false
            }
            
            showSnapshot(forIndex: 2) {}
        } else {
            showSnapshot(forIndex: 0) {}
        }
    }
    
    func playSnapshotAudio() {
        audioPlayerManager?.stop(fileName: .ambience)
        audioPlayerManager?.play(fileName: .barSnapshotsBGM)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        switch snapshotIndex {
        case 1:
            sceneManager?.presentCrashQTEScene()
        default:
            hideSnapshot(forIndex: snapshotIndex) {
                if self.snapshotIndex == self.snapshots.count - 1 {
                    self.audioPlayerManager?.stop(fileName: .barSnapshotsBGM)
                    self.sceneManager?.presentBarScene(playerPosition: .radioSpot, transition: nil)
                } else {
                    self.showSnapshot(forIndex: self.snapshotIndex + 1) {}
                }
            }
        }
    }
}



