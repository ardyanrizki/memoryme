//
//  DecorativeItem.swift
//  MC2
//
//  Created by Ivan on 24/06/23.
//

import SpriteKit
import GameplayKit

class DecorativeItem: GKEntity {
    
    var node: SKSpriteNode
    
    init(node: SKSpriteNode, name: String, position point: CGPoint) {
        self.node = node
        self.node.name = name
        
        super.init()
        addingComponents(name: name, position: point)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingComponents(name: String, position: CGPoint) {
        let itemRenderComponent = RenderComponent(
            node: self.node,
            position: position
        )
        
        let physicalComponent = PhysicsComponent(physicsType: .item, node: node)
        
        addComponent(itemRenderComponent)
        addComponent(physicalComponent)
    }
}
