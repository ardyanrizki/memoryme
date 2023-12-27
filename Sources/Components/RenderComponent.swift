//
//  RenderComponent.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

/// `RenderComponent` is responsible for managing the rendering of an entity using an SKSpriteNode.
class RenderComponent: GKComponent {
    
    /// The sprite node used for rendering.
    let node: SKSpriteNode
    
    /// Initializes a render component with a texture and position.
    /// - Parameters:
    ///   - texture: The texture to be used by the sprite node.
    ///   - position: The initial position of the sprite node.
    init(with texture: SKTexture, at position: CGPoint) {
        node = SKSpriteNode(texture: texture)
        node.position = position
        
        super.init()
    }
    
    /// Initializes a render component with a pre-existing sprite node.
    /// - Parameters:
    ///   - node: The sprite node to be used for rendering.
    ///   - position: The initial position of the sprite node (optional).
    init(node: SKSpriteNode, at position: CGPoint? = nil) {
        self.node = node
        if let position {
            node.position = position
        }
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
}
