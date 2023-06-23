//
//  InteractiveItem.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 22/06/23.
//

import SpriteKit
import GameplayKit

class IntercativeItem: GKEntity {
    
    var node: SKSpriteNode?
    
    init(position point: CGPoint, name: String) {
        super.init()
        addingComponents(position: point, name: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingComponents(position point: CGPoint, name: String) {
        let renderComponent = RenderComponent(type: .vase, position: point)
        
        node = renderComponent.node
        
        guard let node else {
            print("Error: No item node available.")
            return
        }
        
        let physicalComponent = PhysicsComponent(type: .item, renderComponent: renderComponent)
        
        node.name = "vase"
        addComponent(renderComponent)
        addComponent(physicalComponent)
    }
}
