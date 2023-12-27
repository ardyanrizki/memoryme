//
//  GameViewController.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import UIKit
import SpriteKit
import AVFoundation

/// The main view controller managing the game's presentation and setup.
class GameViewController: UIViewController {
    
    /// Manages the state of the game.
    var gameStateManager: GameStateManager?
    
    /// Manages audio playback during the game.
    var audioPlayerManager: AudioPlayerManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameState()
        setupAudioPlayerManager()
        presentTitleScreen()
    }
    
    /// Determines the supported interface orientations based on the device type.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    /// Hides the status bar.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    /// Sets up the game state manager and initializes the opening scene.
    private func setupGameState() {
        gameStateManager = GameStateManager()
        gameStateManager?.setState(key: .sceneActivity, value: .sceneActivityValue(.opening))
    }
    
    /// Initializes the audio player manager for handling background music.
    private func setupAudioPlayerManager() {
        audioPlayerManager = AudioPlayerManager()
    }
}

// MARK: - Audio Player Extension
extension GameViewController {
    
    /// Stops the currently playing background music.
    func stopBackgroundMusic() {
        audioPlayerManager?.stop(audioFile: .ambience)
    }
    
    /// Plays background music with the specified audio file identifier.
    ///
    /// - Parameter audioFile: The identifier of the audio file to be played (default is `.ambience`).
    func playBackgroundMusic(audioFile: AudioFile = .ambience) {
        audioPlayerManager?.play(audioFile: audioFile, type: .background)
    }
}

// MARK: - Scene Presentation Extension
extension GameViewController {
    
    /// Presents a SpriteKit scene with an optional transition.
    ///
    /// - Parameters:
    ///   - scene: The SKScene to be presented.
    ///   - transition: An optional SKTransition for scene presentation.
    func present(scene: SKScene, transition: SKTransition? = nil) {
        if let view = self.view as! SKView? {
            // Remove existing gesture recognizers
            if let gestureRecognizers = view.gestureRecognizers {
                for recognizer in gestureRecognizers {
                    view.removeGestureRecognizer(recognizer)
                }
            }
            
            // Configure the scene properties
            scene.scaleMode = .aspectFill
            scene.physicsWorld.gravity = CGVector.zero
            
            // Present the scene with or without transition
            if let transition = transition {
                view.presentScene(scene, transition: transition)
            } else {
                view.presentScene(scene)
            }
            
            // Set view properties
            view.ignoresSiblingOrder = true
            
            #if DEBUG
            view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
            #else
            view.showsPhysics = false
            #endif
        }
    }
}
