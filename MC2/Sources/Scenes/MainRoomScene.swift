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
    
    static func sharedScene(playerPosition: PositionIdentifier) -> MainRoomScene? {
        let scene = MainRoomScene(fileNamed: Constants.mainRoomScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        super.player?.lay()
    }
}
