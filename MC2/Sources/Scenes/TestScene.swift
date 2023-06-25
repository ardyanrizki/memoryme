//
//  TestScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit
import GameplayKit

class TestScene: PlayableScene, PlayableSceneProtocol {
    typealias T = TestScene
    
    static func sharedScene(playerAt position: PositionIdentifier) -> TestScene? {
        let scene = TestScene(fileNamed: "TestScene")
        scene?.setup(playerAt: position)
        return scene
    }
}
