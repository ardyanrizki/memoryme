//
//  TitleScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 20/06/23.
//

import SpriteKit
import GameplayKit

class TitleScene: SKScene {
    var sceneManager: SceneManagerProtocol?
    
    var playButton: SKSpriteNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        setupNodes()
        
        // TODO: uncomment when the experiment is done
        // startCarousel()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playButton.contains(location) {
                sceneManager?.presentMainRoomScene(playerPosition: .mainRoomStart)
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
    
    // TODO: still an experiment to create auto scroll carousel
    private func startCarousel() {
        if let carouselNode = childNode(withName: "carouselNode") as SKNode? {

            let background = childNode(withName: "background") as! SKSpriteNode
            let carouselChildren = carouselNode.children
            for (_, childNode) in carouselChildren.enumerated() {
                let originX = childNode.position.x
                let originY = childNode.position.y
                
                //let counter = index + 1
                let targetPosition = CGPoint(x: originX + 150, y: originY + 400.0)

                let moveAction = SKAction.move(to: targetPosition, duration: 4.0)
                
                // Create the reset action to move the image nodes back to their initial positions
                let resetAction = SKAction.run {
                    if background.intersects(childNode) {
                        // childNode.position = CGPoint(x: childNode.position.x + 150, y: childNode.position.y + 400)
                        childNode.position = carouselChildren[0].position
                    } else {
                        // childNode.position = CGPoint(x: originX + 450, y: originY + 1200)
                        childNode.position = carouselChildren[0].position
                    }
                }
                
                let sequenceAction = SKAction.sequence([moveAction, resetAction])

                // Run the action on the node
                childNode.run(SKAction.repeatForever(sequenceAction))
                // childNode.run(SKAction.repeat(sequenceAction, count: 1))
            }
        }

    }
}
