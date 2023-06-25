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
        let scene = TestScene(fileNamed: Constants.testScene)
        scene?.setup(playerAt: position)
        return scene
    }
    
    override func playerDidIntersects(with itemIdentifier: ItemIdentifier) {
        if itemIdentifier == .vase {
            print("Item triggered")
            dialogBox?.show(dialog: DialogResources.strangeVase, from: self)
        }
    }
}
