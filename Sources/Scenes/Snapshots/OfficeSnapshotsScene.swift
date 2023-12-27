//: [Previous](@previous)

import Foundation

//
//  OfficeSnapshotsScene.swift
//  Memoryme
//
//  Created by Ivan on 01/07/23.
//

import SpriteKit

/// A scene to display snapshots in an office setting with interactive features.
class OfficeSnapshotsScene: SnapshotsScene {

    // MARK: - Scene Lifecycle

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        playSnapshotAudio()
        showInitialSnapshot()
    }
    
    // MARK: - Snapshot Audio
    
    /// Plays audio associated with snapshots.
    private func playSnapshotAudio() {
        audioPlayerManager?.play(audioFile: .officeSnapshotsBGM, type: .background)

        if currentSnapshotIndex == snapshotNodes.count - 2 {
            audioPlayerManager?.play(audioFile: .phone, type: .soundEffect)
            audioPlayerManager?.setVolume(audioFile: .phone, to: 0.4)
        }
    }

    // MARK: - Touch Handling

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }

        guard let touch = touches.first, let touchedNode = getNodeTouched(touch) else {
            return
        }

        handleTouchedNode(touchedNode)
    }

    // MARK: - Snapshot Handling

    /// Displays the initial snapshot when the scene is loaded.
    private func showInitialSnapshot() {
        Task {
            await showSnapshot()
            self.playSnapshotAudio()
        }
    }

    // MARK: - Dialog Handling

    /// Initiates a dialog sequence for a call from mom.
    private func startMomsCallDialog() async {
        await dialogBox?.start(dialogs: DialogResources.office5OnPhoneSequence, from: self)
    }

    /// Initiates a dialog sequence for rejecting a call from mom.
    private func rejectedMomsCallDialog() async {
        await dialogBox?.start(dialog: DialogResources.office6RejectPhone, from: self)
    }

    // MARK: - Node Handling

    /// Retrieves the touched node at the given touch location.
    ///
    /// - Parameter touch: The touch event.
    /// - Returns: The touched SKNode.
    private func getNodeTouched(_ touch: UITouch) -> SKNode? {
        let touchedLocation = touch.location(in: self)
        return self.nodes(at: touchedLocation).first
    }

    /// Handles the interaction with a touched node.
    ///
    /// - Parameter touchedNode: The node that was touched.
    private func handleTouchedNode(_ touchedNode: SKNode) {
        switch touchedNode.name {
        case Constants.acceptNode:
            handleAcceptPhone()
        case Constants.declineNode:
            handleDeclinePhone()
        default:
            if !isLastSnapshot {
                Task {
                    await hideSnapshot()
                    await showSnapshot()
                    playSnapshotAudio()
                }
            }
        }
    }

    // MARK: - Action Handling

    /// Handles the action when the phone call is accepted.
    private func handleAcceptPhone() {
        Task {
            await hideSnapshot()
            acceptedPhoneAction()
        }
    }

    /// Handles the action when the phone call is declined.
    private func handleDeclinePhone() {
        audioPlayerManager?.stop(audioFile: .phone)
        gameStateManager?.setState(key: .momsCallAccepted, value: .boolValue(false))
        
        Task {
            await rejectedMomsCallDialog()
            transitionToOfficeRoomScene()
        }
    }

    /// Handles the action when the phone call is accepted, updating the game state and transitioning to the next scene.
    private func acceptedPhoneAction() {
        audioPlayerManager?.stop(audioFile: .phone)
        gameStateManager?.setState(key: .momsCallAccepted, value: .boolValue(true))

        Task {
            await startMomsCallDialog()
            transitionToOfficeRoomScene()
        }
    }

    // MARK: - Scene Transition

    /// Transitions to the office room scene after the phone call.
    private func transitionToOfficeRoomScene() {
        let whiteFade = SKTransition.fade(with: .white, duration: 1)
        scenePresenter?.presentOffice(playerPosition: .officeComputerSpot, transition: whiteFade)
    }
}

