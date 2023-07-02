//
//  GameViewController.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import UIKit
import SpriteKit

protocol SceneManagerProtocol: AnyObject {
    func presentTitleScene()
    func presentMainRoomScene(playerPosition: PositionIdentifier)
    func presentOfficeRoomScene(playerPosition: PositionIdentifier, transition: SKTransition?)
    func presentBedroomScene()
    func presentBedroomTidyScene()
    func presentBarScene()
    func presentHospitalRoomScene()
    func presentMGPasswordScene()
    func presentMGMatchingNumbersScene()
    func presentMGPhotoAlbumScene()
    func presentMGPhotoAlbumSecondScene()
    func presentMGRadioScene()
    func presentCrashQTEScene()
    func presentOfficeSnapshotScene()
    func presentSnapshotBedroomScene()
    func presentSnapshotBarScene(state: String, first: String)
}

class GameViewController: UIViewController {
    
    var gameState: GameState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // presentTitleScene()
        presentMGMatchingNumbersScene()
        // presentOfficeSnapshotScene()
        setupGameState()
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
}

// MARK: Audio Player
extension GameViewController {
    
    // TODO: duplicate code from PlayableScene
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    // TODO: duplicate code from PlayableScene
    func playBackgroundMusic(filename: String) {
        // Stop the current background music if playing
        stopBackgroundMusic()
        
        // Get the path to the new music file
        let filePath = Bundle.main.path(forResource: filename, ofType: nil)
        if let path = filePath {
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create the audio player
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                
                // Configure the audio player settings
                audioPlayer.numberOfLoops = -1 // Loop indefinitely
                audioPlayer.volume = 0.5 // Adjust the volume as needed
                
                // Play the background music
                audioPlayer.play()
            } catch {
                // Error handling if the audio player fails to initialize
                print("Could not create audio player: \(error.localizedDescription)")
            }
        } else {
            print("Music file not found: \(filename)")
        }
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
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentOfficeRoomScene(playerPosition: PositionIdentifier, transition: SKTransition? = nil) {
        guard let scene = OfficeRoomScene.sharedScene(playerPosition: playerPosition) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        present(scene: scene, transition: transition)
    }
    
    func presentBedroomScene() {
        guard let scene = BedroomScene.sharedScene(playerPosition: .bedroomEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBedroomTidyScene() {
        guard let scene = BedroomScene.sharedSceneTidy(playerPosition: .bedroomEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBarScene() {
        guard let scene = BarScene.sharedScene(playerPosition: .barEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentHospitalRoomScene() {
        guard let scene = HospitalRoomScene.sharedScene(playerPosition: .hospitalEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //MARK: MINI GAME SCENES
    //Mini Game 1 - Input Password
    func presentMGPasswordScene(){
        guard let scene = InputPasswordScene(fileNamed: Constants.inputPasswordScene) else { return }
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 2 - Matching Numbers
    func presentMGMatchingNumbersScene(){
        guard let scene = MatchingNumberScene(fileNamed: Constants.matchingNumberScene) else { return }
        scene.sceneManager = self
        present(scene: scene)
    }
    
    //Mini Game 3 - Drag and drop photos to album

    func presentMGPhotoAlbumScene(){
        guard let scene = PhotoAlbumGameScene(fileNamed: Constants.photoAlbumScene) else {return}
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentMGPhotoAlbumSecondScene() {
        guard let scene = PhotoAlbumGameSecondScene(fileNamed: Constants.photoAlbumSecondScene) else {return}
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 4 - Radio Scene
    func presentMGRadioScene(){
        guard let scene = RadioScene(fileNamed: Constants.radioScene) else {return}
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 5 - QTE
    func presentCrashQTEScene(){
        guard let scene = CrashQTEScene(fileNamed: Constants.crashQTEScene) else {return}
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    // MARK: SNAPSHOTS
    // Office Snapshots
    func presentOfficeSnapshotScene() {
        guard let scene = OfficeSnapshotsScene(fileNamed: Constants.officeSnapshotsScene) else {return}
        scene.sceneManager = self
        
        let fade = SKTransition.fade(with: .white, duration: 1.5)
        present(scene: scene, transition: fade)
    }
    
    // Bedroom Snapshots
    func presentSnapshotBedroomScene(){
        guard let scene = BedroomSnapshotsScene(fileNamed: Constants.bedroomSnapshotsScene) else {return}
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 1.5)
        present(scene: scene, transition: fade)
    }
    
    //Snapshots Bar
    func presentSnapshotBarScene(state: String, first: String) {
        guard let scene = BarSnapshotsScene(fileNamed: Constants.barSnapshotsScene) else {return}
        scene.firstCutscene = "first"
        scene.choice = ""
        scene.sceneManager = self
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
            if let transition {
                view.presentScene(scene, transition: transition)
            } else {
                view.presentScene(scene)
            }
            
            scene.scaleMode = .aspectFill
            scene.physicsBody = SKPhysicsBody(edgeLoopFrom: scene.frame)
            scene.physicsWorld.gravity = CGVector.zero
            view.ignoresSiblingOrder = true
#if DEBUG
            view.showsPhysics = true
#else
            view.showsPhysics = false
#endif
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
