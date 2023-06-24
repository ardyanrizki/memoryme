//
//  InteractiveItem.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 22/06/23.
//

import SpriteKit
import GameplayKit

class InteractiveItem: GKEntity {
    
    var node: SKSpriteNode?
    
    init(name textureName: TextureName, at position: CGPoint) {
        super.init()
        addingComponents(name: textureName, position: position)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingComponents(name textureName: TextureName, position point: CGPoint) {
        let renderComponent = RenderComponent(name: textureName, at: point)
        
        node = renderComponent.node
        
        guard let node else {
            print("Error: No item node available.")
            return
        }
        
        let physicalComponent = PhysicsComponent(type: .item, renderComponent: renderComponent)
        
        node.name = textureName
        addComponent(renderComponent)
        addComponent(physicalComponent)
    }
}
