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
    
    static func sharedScene(playerAt position: PositionIdentifier) -> OfficeRoomScene? {
        let scene = OfficeRoomScene(fileNamed: Constants.officeRoomScene)
        scene?.setup(playerAt: position)
        return scene
    }
    
}
