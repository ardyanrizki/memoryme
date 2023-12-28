//
//  TitleScreenScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 20/06/23.
//

import SpriteKit
import GameplayKit

/// A scene representing the title screen or main menu of the game.
class TitleScreenScene: SKScene {
    /// The presenter responsible for handling scene transitions.
    var sceneManager: SceneManager?
    
    /// The sprite node representing the play button.
    var playButton: SKSpriteNode = SKSpriteNode()
    
    /// The carousel node for displaying game features.
    var carousel: CarouselNode!
    
    /// The reversed carousel node for displaying game features in reverse order.
    var reversedCarousel: CarouselNode!
    
    /// Called when the scene is presented in the view.
    override func didMove(to view: SKView) {
        setupNodes()
        
        carousel = childNode(withName: "carouselNode") as? CarouselNode
        reversedCarousel = childNode(withName: "reverseCarouselNode") as? CarouselNode
        carousel.setup()
        reversedCarousel.setup(isReversed: true)
    }
    
    /// Called when a touch event ends on the scene.
    ///
    /// - Parameters:
    ///   - touches: A set of touches that occurred on the screen.
    ///   - event: The UIEvent object containing touch event information.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playButton.contains(location) {
                sceneManager?.presentHall(playerPosition: .hallStart)
            }
        }
    }
}

// MARK: - Private Methods
extension TitleScreenScene {
    /// Sets up the nodes and configurations needed for the title scene.
    private func setupNodes() {
        if let playButton = childNode(withName: TextureResources.startButton) as? SKSpriteNode {
            self.playButton = playButton
            self.playButton.zPosition = 10
        }
    }
}
