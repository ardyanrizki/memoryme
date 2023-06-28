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
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier) {}
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier) {
        if itemIdentifier == .vase {
            // Testing line for sequence dialog.
            dialogBox?.startSequence(dialogs: [
                DialogResources.opening_1_solo_seq1,
                DialogResources.opening_2_officeDesk_alt1
            ], from: self)
        }
    }
}
