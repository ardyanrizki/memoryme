//
//  GameViewController.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import UIKit
import SpriteKit
import AVFoundation

protocol SceneManagerProtocol: AnyObject {
    func presentTitleScene()
    func presentMainRoomScene(playerPosition: PositionIdentifier)
    func presentOfficeRoomScene(playerPosition: PositionIdentifier,transition: SKTransition?)
    func presentBedroomScene(playerPosition: PositionIdentifier)
    func presentBarScene(playerPosition: PositionIdentifier, transition: SKTransition?)
    func presentHospitalRoomScene()
    func presentMGInputPinScene()
    func presentMGMatchingNumbersScene()
    func presentMGPhotoAlbumScene()
    func presentMGPhotoAlbumSecondScene()
    func presentMGRadioScene()
    func presentCrashQTEScene()
    func presentOfficeSnapshotsScene()
    func presentBedroomSnapshotsScene()
    func presentBarSnapshotsScene()
}

class GameViewController: UIViewController, AVAudioPlayerDelegate {
    
    var gameState: GameState?
    
    var audioPlayer: AVAudioPlayer!
    
    var audioPlayerManager: AudioPlayerManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameState()
        setupAudioPlayerManager()
//        presentTitleScene()
//        presentOfficeRoomScene(playerPosition: .officeEntrance)
        presentBedroomScene(playerPosition: .bedroomEntrance)
//        presentBarScene(playerPosition: .barEntrance)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupGameState() {
        gameState = GameState()
        gameState?.setState(key: .sceneActivity, value: .sceneActivityValue(.opening))
    }
    
    private func setupAudioPlayerManager() {
        audioPlayerManager = AudioPlayerManager()
    }
}

// MARK: Audio Player
extension GameViewController {
    
    // TODO: duplicate code from PlayableScene
    func stopBackgroundMusic() {
        audioPlayerManager?.stop(fileName: .ambience)
    }
    
    // TODO: duplicate code from PlayableScene
    func playBackgroundMusic(filename: String) {
        audioPlayerManager?.play(fileName: .ambience)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopBackgroundMusic()
    }
    
    func checkCurrentBackgroundMusic() {
        if audioPlayer == nil {
            playBackgroundMusic(filename: Constants.ambience)
        }
    }
    
    // TODO: duplicate code from PlayableScene
    func changeBackgroundMusic(filename: String) {
        playBackgroundMusic(filename: filename)
    }
}

extension GameViewController: SceneManagerProtocol {
    
    func presentTitleScene() {
        guard let scene = TitleScene(fileNamed: Constants.titleScene) else { return }
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentMainRoomScene(playerPosition: PositionIdentifier) {
        guard let scene = MainRoomScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentOfficeRoomScene(playerPosition: PositionIdentifier, transition: SKTransition? = nil) {
        guard let scene = OfficeRoomScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        present(scene: scene, transition: transition)
    }
    
    func presentBedroomScene(playerPosition: PositionIdentifier) {
        guard let gameState else { return }
        let isTidy = gameState.getState(key: .friendsPhotosKept)?.isEqual(with: true) ?? false
        guard let scene = BedroomScene.sharedScene(isTidy: isTidy ? true : false, playerPosition: playerPosition) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBarScene(playerPosition: PositionIdentifier, transition: SKTransition? = nil) {
        guard let scene = BarScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
        checkCurrentBackgroundMusic()
    }
    
    func presentHospitalRoomScene() {
        guard let scene = HospitalRoomScene.sharedScene(playerPosition: .hospitalEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //MARK: MINI GAME SCENES
    //Mini Game 1 - Input Pin
    func presentMGInputPinScene() {
        guard let scene = InputPinScene(fileNamed: Constants.inputPinScene) else { return }
        scene.sceneManager = self
        //        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 2 - Matching Numbers
    func presentMGMatchingNumbersScene() {
        guard let scene = MatchingNumberScene(fileNamed: Constants.matchingNumberScene) else { return }
        scene.sceneManager = self
        //        scene.gameState = gameState
        present(scene: scene)
    }
    
    //Mini Game 3 - Drag and drop photos to album
    
    func presentMGPhotoAlbumScene() {
        guard let scene = PhotoAlbumScene(fileNamed: Constants.photoAlbumScene) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentMGPhotoAlbumSecondScene() {
        guard let scene = PhotoAlbumGameSecondScene(fileNamed: Constants.photoAlbumSecondScene) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 4 - Radio Scene
    func presentMGRadioScene() {
        guard let scene = RadioScene(fileNamed: Constants.radioScene) else {return}
        scene.sceneManager = self
        //        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
        stopBackgroundMusic()
    }
    
    //Mini Game 5 - QTE
    func presentCrashQTEScene() {
        guard let scene = CrashQTEScene(fileNamed: Constants.crashQTEScene) else {return}
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    // MARK: SNAPSHOTS
    // Office Snapshots
    func presentOfficeSnapshotsScene() {
        guard let scene = OfficeSnapshotsScene(fileNamed: Constants.officeSnapshotsScene) else {return}
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(with: .white, duration: 1.5)
        present(scene: scene, transition: fade)
    }
    
    // Bedroom Snapshots
    func presentBedroomSnapshotsScene() {
        guard let scene = BedroomSnapshotsScene(fileNamed: Constants.bedroomSnapshotsScene) else {return}
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 1.5)
        // Stop the background music
        stopBackgroundMusic()
        // Play the cutSceneBedroom music
        playBackgroundMusic(filename: Constants.cutSceneBedroom)
        present(scene: scene, transition: fade)
    }
    
    //Snapshots Bar
    func presentBarSnapshotsScene() {
        guard let scene = BarSnapshotsScene(fileNamed: Constants.barSnapshotsScene) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        scene.audioPlayerManager = audioPlayerManager
        let fade = SKTransition.fade(withDuration: 1.5)
        present(scene: scene, transition: fade)
    }
    
}

extension GameViewController {
    
    private func present(scene: SKScene, transition: SKTransition? = nil){
        if let view = self.view as! SKView? {
            if let gestureRecognizers = view.gestureRecognizers {
                for recognizer in gestureRecognizers {
                    view.removeGestureRecognizer(recognizer)
                }
            }
            
            scene.scaleMode = .aspectFill
            scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
            scene.physicsWorld.gravity = CGVector.zero
            
            if let transition {
                view.presentScene(scene, transition: transition)
            } else {
                view.presentScene(scene)
            }
            
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
