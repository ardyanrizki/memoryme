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
    
}
