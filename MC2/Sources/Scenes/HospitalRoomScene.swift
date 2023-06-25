//
//  HospitalRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 21/06/23.
//

import SpriteKit
import GameplayKit

class HospitalRoomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = HospitalRoomScene
    
    static func sharedScene(playerAt position: PositionIdentifier) -> HospitalRoomScene? {
        let scene = HospitalRoomScene(fileNamed: Constants.hospitalScene)
        scene?.setup(playerAt: position)
        return scene
    }
    
}
