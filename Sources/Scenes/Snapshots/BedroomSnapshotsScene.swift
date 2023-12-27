//
//  BedroomSnapshotsScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit

class BedroomSnapshotsScene: SnapshotsScene {

    // MARK: - Scene Lifecycle

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSceneAudio()
        showInitialSnapshot()
    }
    
    // MARK: - Snapshot Audio
    
    func setupSceneAudio() {
        audioPlayerManager?.play(audioFile: .bedroomSnapshotsBGM, type: .background)
    }

    // MARK: - Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled, let touch = touches.first else { return }
        
        Task {
            await handleSnapshotTouch(touch)
        }
    }

    // MARK: - Snapshot Handling

    private func showInitialSnapshot() {
        Task {
            await showSnapshot()
        }
    }

    private func handleSnapshotTouch(_ touch: UITouch) async {
        if isLastSnapshot {
            let touchLocation = touch.location(in: self)
            guard let touchedNode = self.nodes(at: touchLocation).first else { return }
            
            await handleButtonTouch(touchedNode)
            return
        }
        
        hideAndShowNextSnapshot()
    }

    private func hideAndShowNextSnapshot() {
        Task {
            await hideSnapshot()
            await showNextSnapshotIfNeeded()
        }
    }

    private func showNextSnapshotIfNeeded() async {
        guard currentSnapshotIndex < snapshotNodes.count - 1 else { return }
        
        await showSnapshot()
        
        if isLastSnapshot {
            handleLastSnapshot()
        }
    }

    private func handleLastSnapshot() {
        audioPlayerManager?.play(audioFile: .lighter, type: .soundEffect)
        setupBurnChoiceButtons(isHidden: false)
    }

    // MARK: - Button Handling

    private func handleButtonTouch(_ touchedNode: SKNode) async {
        switch touchedNode.name {
        case Constants.burnButton:
            await handleBurnButtonTouch()
        case Constants.keepButton:
            await handleKeepButtonTouch()
        default:
            break
        }
    }

    private func handleBurnButtonTouch() async {
        audioPlayerManager?.play(audioFile: .burn, type: .soundEffect)
        await handleChoiceButtonTouch(isKept: false)
    }

    private func handleKeepButtonTouch() async {
        await handleChoiceButtonTouch(isKept: true)
    }

    private func handleChoiceButtonTouch(isKept: Bool) async {
        setupBurnChoiceButtons(isHidden: true)
        
        let dialogResource = isKept ? DialogResources.bedroom4WithPhotoAlt1 : DialogResources.bedroom4WithPhotoAlt2
        await dialogBox?.start(dialogs: [dialogResource], from: self)
        self.handleDialogCompletion(isKept: isKept)
    }

    private func handleDialogCompletion(isKept: Bool) {
        gameStateManager?.setState(key: .friendsPhotosKept, value: .boolValue(isKept))
        audioPlayerManager?.play(audioFile: .ambience, type: .background)
        
        let position: CharacterPosition = isKept ? .bedroomCenter : .bedroomPhotoAlbumSpot
        scenePresenter?.presentBedroom(playerPosition: position)
    }

    // MARK: - Button Visibility

    private func setupBurnChoiceButtons(isHidden: Bool) {
        childNode(withName: Constants.keepButton)?.alpha = isHidden ? 0 : 1
        childNode(withName: Constants.burnButton)?.alpha = isHidden ? 0 : 1
    }
}

