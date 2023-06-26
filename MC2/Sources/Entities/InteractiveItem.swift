//
//  InteractiveItem.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 22/06/23.
//

import SpriteKit
import GameplayKit

enum ItemTextureType {
    case normal
    case tidy
    case messy
}

class InteractiveItem: GKEntity {
    
    var node: ItemNode? {
        for case let component as RenderComponent in components {
            return component.node as? ItemNode
        }
        return nil
    }
    
    private var textures: [ItemTextureType: SKTexture]?
    
    var textureType: ItemTextureType = .tidy
    
    init(from node: ItemNode, textures: [ItemTextureType: SKTexture]) {
        guard let firstTexture = textures.first else { fatalError(.errorTextureNotFound) }
        super.init()
        self.textures = textures
        self.textureType = firstTexture.key
        // First texture always run for the first time as a default texture.
        addingComponents(node: node)
        node.texture = firstTexture.value
    }
    
    init(with identifier: ItemIdentifier, at point: CGPoint, withScene scene: SKScene) {
        guard let node = identifier.getNode(from: scene) else {
            fatalError(.errorNodeNotFound)
        }
        super.init()
        addingComponents(node: node)
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    private func addingComponents(node: ItemNode) {
        let renderComponent = RenderComponent(node: node)
        let physicalComponent = PhysicsComponent(type: .item, renderComponent: renderComponent)
        addComponent(renderComponent)
        addComponent(physicalComponent)
    }
}
