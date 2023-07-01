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
    func presentOfficeRoomScene()
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
    func presentSnapshotBedroomScene()
}

class GameViewController: UIViewController {
    
    var gameState: GameState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presentTitleScene()
        presentMGRadioScene()
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
    
    func presentOfficeRoomScene() {
        guard let scene = OfficeRoomScene.sharedScene(playerPosition: .officeEntrance) else { return }
        scene.sceneManager = self
        scene.gameState = gameState
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
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
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Mini Game 5 - QTE
    func presentCrashQTEScene(){
        guard let scene = CrashQTEScene(fileNamed: Constants.crashQTEScene) else {return}
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    //Snapshots Bedroom
    func presentSnapshotBedroomScene(){
        guard let scene = BedroomSnapshotsScene(fileNamed: Constants.bedroomSnapshotsScene) else {return}
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
