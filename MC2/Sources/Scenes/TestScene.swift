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
    
    static func sharedScene(playerPosition: PositionIdentifier) -> TestScene? {
        let scene = TestScene(fileNamed: Constants.testScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier) {
//        if itemIdentifier == .vase {
//            print("Item triggered")
//            dialogBox?.show(dialog: DialogResources.strangeVase, from: self)
//        }
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier) {
        if itemIdentifier == .vase {
            print("Item triggered")
            dialogBox?.show(dialog: DialogResources.strangeVase, from: self)
        }
    }
}
