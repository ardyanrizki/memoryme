//
//  BarScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BarScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = BarScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> BarScene? {
        let scene = BarScene(fileNamed: Constants.barScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        
        
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        if node.position.y < (player?.node?.position.y)! {
            node.zPosition = 20
        } else {
            if node.zPosition > 10 {
                node.zPosition = 10
            }
        }
    }
}

// MARK: Scene's Events
extension BarScene {
    
    func startPlayRadioEvent() {
        
    }
    
    func startRadioGame() {
        
    }
    
    func startTheStrangerSnapshots() {
        
    }
    
    func startTheBartenderEvent() {
        
    }
    
}
