//
//  OfficeSnapshotsScene.swift
//  Memoryme
//
//  Created by Ivan on 01/07/23.
//

import SpriteKit
import GameplayKit

class OfficeSnapshotsScene: SnapshotsBaseScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        audioPlayerManager?.add(fileName: .officeSnapshotsBGM)
        showSnapshot(forIndex: 0) {
            self.playSnapshotAudio()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else {
            return
        }
        
        let touchedLocation = touch.location(in: self)
        
        if snapshotIndex < snapshots.count - 1 {
            hideSnapshot(forIndex: snapshotIndex) {
                self.showSnapshot(forIndex: self.snapshotIndex + 1) {
                    self.playSnapshotAudio()
                }
            }
        } else {
            let touchedLocation = touch.location(in: self)
            if let touchedNode = self.nodes(at: touchedLocation).first {
            
                switch(touchedNode.name) {
                case Constants.acceptNode:
                    // Doing action if accepting the phone.
                    hideSnapshot(forIndex: snapshotIndex) {
                        self.gameState?.setState(key: .momsCallAccepted, value: .boolValue(true))
                        
                        self.startMomsCallDialog {
                            let whiteFade = SKTransition.fade(with: .white, duration: 1)
                            self.sceneManager?.presentOfficeRoomScene(
                                playerPosition: .computerSpot,
                                transition: whiteFade
                            )
                        }
                    }
                case Constants.declineNode:
                    // Doing action if decline the phone.
                    gameState?.setState(key: .momsCallAccepted, value: .boolValue(false))
                    rejectedMomsCallDialog {
                        let whiteFade = SKTransition.fade(with: .white, duration: 1)
                        self.sceneManager?.presentOfficeRoomScene(
                            playerPosition: .computerSpot,
                            transition: whiteFade
                        )
                    }
                default:
                    break
                }
            }
        }
    }
    
    func playSnapshotAudio() {
        audioPlayerManager?.stop(fileName: .ambience)
        audioPlayerManager?.play(fileName: .officeSnapshotsBGM)
        
        if snapshotIndex == snapshots.count - 1{
            audioPlayerManager?.play(fileName: .phone)
            audioPlayerManager?.setVolume(0.4, fileName: .phone)
        }
    }
    
    func startMomsCallDialog(completion: @escaping () -> Void) {
        dialogBox?.startSequence(dialogs: [
            DialogResources.office_7_onphone_seq1,
            DialogResources.office_8_onphone_seq2,
            DialogResources.office_9_onphone_seq3,
            DialogResources.office_10_onphone_seq4,
            DialogResources.office_11_onphone_seq5,
            DialogResources.office_12_onphone_seq6,
            DialogResources.office_13_onphone_seq7,
            DialogResources.office_14_onphone_seq8,
            DialogResources.office_15_onphone_seq9,
            DialogResources.office_16_onphone_seq10,
            DialogResources.office_17_onphone_seq11,
            DialogResources.office_18_onphone_seq12,
            DialogResources.office_19_onphone_seq13,
            DialogResources.office_20_onphone_seq14,
            DialogResources.office_21_onphone_seq15,
            DialogResources.office_22_onphone_seq16,
            DialogResources.office_23_onphone_seq17,
            DialogResources.office_24_onphone_seq18,
            DialogResources.office_25_onphone_seq19,
            DialogResources.office_26_onphone_seq20,
            DialogResources.office_27_onphone_seq21,
            DialogResources.office_28_onphone_seq22
        ], from: self, completion: {
            completion()
        })
    }
    
    func rejectedMomsCallDialog(completion: @escaping (() -> Void)) {
        dialogBox?.start(dialog: DialogResources.office_29_rejectPhone, from: self, completion: completion)
    }
}
