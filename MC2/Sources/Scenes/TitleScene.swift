//
//  TitleScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 20/06/23.
//

import SpriteKit
import GameplayKit

class TitleScene: SKScene {
    var sceneManagerDelegate: SceneManagerProtocol?
    
    var playButton: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        setupNodes()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playButton.contains(location) {
                sceneManagerDelegate?.presentMainRoomScene()
            }
        }
    }
}

extension TitleScene {
    private func setupNodes() {
        if let playButton = childNode(withName: TextureResources.startButton) as? SKSpriteNode {
            self.playButton = playButton
            self.playButton.zPosition = 10
        }
    }
}
