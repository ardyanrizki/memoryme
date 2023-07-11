//
//  HospitalRoomScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 21/06/23.
//

import SpriteKit
import GameplayKit

class HospitalRoomScene: RoomBaseScene, PlayableSceneProtocol {
    
    typealias T = HospitalRoomScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> HospitalRoomScene? {
        let scene = HospitalRoomScene(fileNamed: Constants.hospitalScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
}
