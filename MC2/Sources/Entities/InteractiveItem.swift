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
    
    init(position point: CGPoint, name: String, type: ItemType) {
        super.init()
        addingComponents(position: point, name: name, type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingComponents(position point: CGPoint, name: String, type: ItemType) {
        let itemRenderComponent = RenderComponent(type: type, position: point)
        
        node = itemRenderComponent.itemNode
        
        guard let node else {
            print("Error: No item node available.")
            return
        }
        
        let physicalComponent = PhysicsComponent(physicsType: .item, node: node)
        
        node.name = name
        addComponent(itemRenderComponent)
        addComponent(physicalComponent)
    }
}
