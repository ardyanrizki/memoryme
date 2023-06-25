//
//  MainRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class MainRoomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = MainRoomScene
    
    static func sharedScene(playerAt position: PositionIdentifier) -> MainRoomScene? {
        let scene = MainRoomScene(fileNamed: Constants.mainRoomScene)
        scene?.setup(playerAt: position)
        return scene
    }
}
