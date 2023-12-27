//
//  PlayableScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

/// A base class for playable scenes in the game.
class PlayableScene: SKScene {
    
    // MARK: - Properties
    
    /// The scene manager responsible for transitioning between scenes.
    weak var scenePresenter: ScenePresenter?
    
    weak var gameStateManager: GameStateManager?
    
    /// The manager for handling audio playback in the scene.
    weak var audioPlayerManager: AudioPlayerManager?
    
    /// The protocol defining scene-blocking behavior.
    var sceneBlocker: SceneBlockerProtocol?
    
    /// The node responsible for displaying dialog boxes.
    var dialogBox: DialogBoxNode?
    
    // MARK: - Setup
    
    /// Sets up the scene with the provided scene manager and audio player manager.
    /// - Parameters:
    ///   - scenePresenter: The scene manager for transitioning between scenes.
    ///   - audioPlayerManager: The audio player manager for handling audio playback.
    func setup(scenePresenter: ScenePresenter?,
               audioPlayerManager: AudioPlayerManager?,
               gameStateManager: GameStateManager?) {
        self.scenePresenter = scenePresenter
        self.audioPlayerManager = audioPlayerManager
        self.gameStateManager = gameStateManager
        setupDialogBox()
    }
    
    // MARK: - Dialog Box
    
    /// Sets up the dialog box if it has not been initialized.
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
    
}
