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
    func presentMemoryRoomScene(roomNumber: Int)
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
    
    func presentMemoryRoomScene(roomNumber: Int) {
        var scene = SKScene()
        let transition = SKTransition.fade(withDuration: 0.5)
        switch roomNumber {
        case 1:
            guard let firstRoomScene = FirstMemoryScene(fileNamed: "FirstMemoryScene") else { return }
            scene = firstRoomScene
        case 2:
            guard let secondRoomScene = SecondMemoryScene(fileNamed: "SecondMemoryScene") else { return }
            scene = secondRoomScene
        case 3:
            guard let thirdRoomScene = ThirdMemoryScene(fileNamed: "ThirdMemoryScene") else { return }
            scene = thirdRoomScene
        default:
            break
        }
        present(scene: scene, transition: transition)
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
