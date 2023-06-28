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
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        
        node.isShowBubble = true
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        if node.position.y < (player?.node?.position.y)! {
            node.zPosition = 20
        } else {
            if node.zPosition > 10 {
                node.zPosition = 10
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        let touchLocation = touch.location(in: self)
//        dialogBox?.handleTouch(on: touchLocation)
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        print("test")
        let bubbleNodePhotoframe = childNode(withName: "bubblePhotoframe")
        if bubbleNodePhotoframe?.alpha == 1 {
            bubbleNodePhotoframe?.alpha = 0
        }
        let bubbleNodeMacbook = childNode(withName: "bubbleMacbook")
        if bubbleNodeMacbook?.alpha == 1 {
            bubbleNodeMacbook?.alpha = 0
        }
    }
    
}
