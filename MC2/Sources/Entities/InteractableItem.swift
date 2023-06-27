//
//  InteractableItem.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 22/06/23.
//

import SpriteKit
import GameplayKit

enum ItemTextureType: String, CaseIterable {
    case normal
    case tidy
    case messy
}

class InteractableItem: GKEntity {
    
    var node: ItemNode? {
        for case let component as RenderComponent in components {
            return component.node as? ItemNode
        }
        return nil
    }
    
    private var textures: [ItemTextureType: SKTexture]? {
        get {
            node?.textures
        }
        set {
            node?.textures = newValue
        }
    }
    
    var textureType: ItemTextureType? {
        get {
            node?.textureType ?? .normal
        }
        set {
            node?.textureType = newValue
        }
    }
    
    init(withNode node: ItemNode, textures: [ItemTextureType: SKTexture]) {
        super.init()
        addingComponents(node: node)
        if node.texture ==  nil {
            // Important! First texture always run for the first time as a fallback texture.
            guard let firstTexture = textures.first else { fatalError(.errorTextureNotFound) }
            node.texture = firstTexture.value
        }
    }
    
    init(withIdentifier identifier: ItemIdentifier, at point: CGPoint, in scene: SKScene) {
        guard let node = identifier.createNode(in: scene, withTextureType: nil) else {
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
