//
//  RenderComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
    
    let node: SKSpriteNode
    
    init(with name: TextureName, at position: CGPoint) {
        let texture = name.getTexture()
        node = SKSpriteNode(texture: texture)
        node.position = position
        super.init()
    }
    
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
