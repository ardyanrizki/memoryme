//
//  BedroomSnapshotsScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

class BedroomSnapshotsScene: SnapshotsBaseScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupAudioPlayer()
        audioPlayerManager?.play(fileName: .bedroomSnapshotsBGM)
        showSnapshot(forIndex: 0, completion: {})
    }
    
    func setupAudioPlayer() {
        audioPlayerManager?.add(fileName: .burn)
        audioPlayerManager?.add(fileName: .lighter)
        audioPlayerManager?.add(fileName: .bedroomSnapshotsBGM)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else { return }
        
        hideSnapshot(forIndex: snapshotIndex) {
            self.showSnapshot(forIndex: self.snapshotIndex + 1) {
                if self.snapshotIndex == self.snapshots.count - 1 {
                    self.audioPlayerManager?.play(fileName: .lighter)
                    self.setupBurnChoiceButtons(isHidden: false)
                }
            }
        }
        
        let touchLocation = touch.location(in: self)
        guard let touchedNode = self.nodes(at: touchLocation).first else { return }
        
        if touchedNode.name == Constants.burnButton {
            audioPlayerManager?.play(fileName: .burn)
            setupBurnChoiceButtons(isHidden: true)
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt2_seq2
            ], from: self, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    self.gameState?.setState(key: .friendsPhotosKept, value: .boolValue(false))
                    self.sceneManager?.presentBedroomScene(playerPosition: .photoAlbumSpot)
                }
            })
        }
        
        if touchedNode.name == Constants.keepButton {
            setupBurnChoiceButtons(isHidden: true)
            dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_4_withPhoto_alt1_seq1
            ], from: self, completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    self.gameState?.setState(key: .friendsPhotosKept, value: .boolValue(true))
                    self.sceneManager?.presentBedroomScene(playerPosition: .bedroomCenter)
                }
            })
        }
    }
    
    private func setupBurnChoiceButtons(isHidden: Bool) {
        self.childNode(withName: Constants.keepButton)?.alpha = isHidden ? 0 : 1
        self.childNode(withName: Constants.burnButton)?.alpha = isHidden ? 0 : 1
    }
}


