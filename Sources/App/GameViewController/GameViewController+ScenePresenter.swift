//
//  GameViewController+ScenePresenterExtension.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 26/12/23.
//

import SpriteKit

// MARK: - Scene Presenter Extension
extension GameViewController: ScenePresenter {
    
    /// Presents the title scene with a fade transition.
    func presentTitleScreen() {
        guard let scene = TitleScreenScene(fileNamed: Constants.titleScene) else { return }
        audioPlayerManager?.stopAll()
        playBackgroundMusic()
        scene.scenePresenter = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the ending scene with a white fade transition and sets up necessary dependencies.
    func presentEndingScreen() {
        guard let scene = EndingScreenScene(fileNamed: Constants.endingScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let whiteFade = SKTransition.fade(with: .white, duration: 4)
        present(scene: scene, transition: whiteFade)
    }
    
    /// Presents the hall room scene with the specified player position and a fade transition.
    func presentHall(playerPosition: CharacterPosition) {
        guard let scene = HallScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the office room scene with the specified player position and optional transition.
    func presentOffice(playerPosition: CharacterPosition, transition: SKTransition? = nil) {
        guard let scene = OfficeScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        present(scene: scene, transition: transition)
    }
    
    /// Presents the bedroom scene with the specified player position and setup based on game state.
    func presentBedroom(playerPosition: CharacterPosition) {
        guard let gameStateManager else { return }
        let isTidy = gameStateManager.getState(key: .friendsPhotosKept)?.isEqual(with: true) ?? false
        guard let scene = BedroomScene.sharedScene(isTidy: isTidy ? true : false, playerPosition: playerPosition) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the bar scene with the specified player position and optional transition.
    func presentBar(playerPosition: CharacterPosition, transition: SKTransition?) {
        guard let scene = BarScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        present(scene: scene, transition: transition)
    }
    
    /// Presents the hospital scene with a white fade transition and sets up necessary dependencies.
    func presentHospital() {
        guard let scene = HospitalScene.sharedScene(playerPosition: .hospitalEntrance) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let whiteFade = SKTransition.fade(with: .white, duration: 2)
        present(scene: scene, transition: whiteFade)
    }
    
    // MARK: MINI GAME SCENES
    
    /// Presents the input pin mini-game scene with a fade transition.
    func presentInputPinMiniGame() {
        guard let scene = PINEntryScene(fileNamed: Constants.inputPinScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the matching numbers mini-game scene without a transition.
    func presentMatchingNumbersMiniGame() {
        guard let scene = MatchingNumberScene(fileNamed: Constants.matchingNumberScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        present(scene: scene)
    }
    
    /// Presents the photo album mini-game scene with a fade transition.
    func presentPhotoAlbumMiniGame() {
        guard let scene = PhotoAlbumScene(fileNamed: Constants.photoAlbumScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the second photo album mini-game scene with a fade transition.
    func presentPhotoAlbumSecondMiniGame() {
        guard let scene = PhotoAlbumGameSecondScene(fileNamed: Constants.photoAlbumSecondScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the radio mini-game scene with a fade transition and stops the background music.
    func presentRadioTunerMiniGame() {
        guard let scene = RadioScene(fileNamed: Constants.radioScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
        stopBackgroundMusic()
    }
    
    /// Presents the Crash QTE mini-game scene with a fade transition.
    func presentCrashQTEMiniGame() {
        guard let scene = CrashQTEScene(fileNamed: Constants.crashQTEScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    // MARK: SNAPSHOTS
    
    /// Presents the office snapshots scene with a white fade transition.
    func presentWorkingSnapshots() {
        guard let scene = OfficeSnapshotsScene(fileNamed: Constants.officeSnapshotsScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(with: .white, duration: 1.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the bedroom snapshots scene with a fade transition.
    func presentPhotoAlbumSnapshots() {
        guard let scene = BedroomSnapshotsScene(fileNamed: Constants.bedroomSnapshotsScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 1.5)
        present(scene: scene, transition: fade)
    }
    
    /// Presents the bar snapshots scene with a fade transition.
    func presentStrangerSnapshots() {
        guard let scene = BarSnapshotsScene(fileNamed: Constants.barSnapshotsScene) else { return }
        scene.setup(scenePresenter: self,
                    audioPlayerManager: audioPlayerManager,
                    gameStateManager: gameStateManager)
        let fade = SKTransition.fade(withDuration: 1.5)
        present(scene: scene, transition: fade)
    }
}
