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
    func presentMainRoomScene()
    func presentOfficeRoomScene()
    func presentBedroomScene()
    func presentBarScene()
    func presentHospitalRoomScene()
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        presentTitleScene()
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
}

extension GameViewController: SceneManagerProtocol {
    func presentTitleScene() {
//        guard let scene = TitleScene(fileNamed: Constants.titleScene) else { return }
        guard let scene = TestScene.sharedScene(playerAt: .mainRoomBedroomDoor) else { return }
        scene.sceneManager = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentMainRoomScene() {
        guard let scene = MainRoomScene(fileNamed: Constants.mainRoomScene) else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentOfficeRoomScene() {
        guard let scene = OfficeRoomScene(fileNamed: Constants.officeRoomScene) else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBedroomScene() {
        guard let scene = BedroomScene(fileNamed: Constants.bedroomScene) else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBarScene() {
        guard let scene = BarScene(fileNamed: Constants.barScene) else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentHospitalRoomScene() {
        guard let scene = HospitalRoomScene(fileNamed: Constants.hospitalScene) else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
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

            view.ignoresSiblingOrder = true
            view.showsPhysics = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
