//
//  GameViewController.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import UIKit
import SpriteKit

protocol SceneManagerDelegate {
    func presentTitleScene()
    func presentMainRoomScene()
    func presentHospitalRoomScene()
    func presentOfficeRoomScene()
    func presentBedroomScene()
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

extension GameViewController: SceneManagerDelegate {
    func presentTitleScene() {
        guard let scene = TitleScene(fileNamed: "TitleScene") else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentMainRoomScene() {
        guard let scene = MainRoomScene(fileNamed: "MainRoomScene") else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentOfficeRoomScene() {
        guard let scene = HospitalRoomScene(fileNamed: "OfficeRoomScene") else { return }
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentBedroomScene() {
        guard let scene = BedroomScene(fileNamed: "BedroomScene") else { return }
        
        scene.sceneManagerDelegate = self
        let fade = SKTransition.fade(withDuration: 0.5)
        present(scene: scene, transition: fade)
    }
    
    func presentHospitalRoomScene() {
        guard let scene = HospitalRoomScene(fileNamed: "HospitalRoomScene") else { return }
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
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
}
