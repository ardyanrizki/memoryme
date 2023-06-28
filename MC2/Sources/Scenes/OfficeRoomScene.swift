//
//  FirstMemoryScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class OfficeRoomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = OfficeRoomScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> OfficeRoomScene? {
        let scene = OfficeRoomScene(fileNamed: Constants.officeRoomScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
}

// MARK: Scene's Events
extension OfficeRoomScene {
    
    func startMomsCallEvent() {
        
    }
    
    func startAngryManagerSnapshots() {
        
    }
    
    func startInputPinGame() {
        
    }
    
    func startMatchNumberGame() {
        
    }
}
