//
//  InteractableItem.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 22/06/23.
//

import SpriteKit
import GameplayKit

enum ItemTextureType: String, CaseIterable {
    case normal
    case tidy
    case messy
    case ripe
    case budding
    case partialBlossom
    case fullBlossom
    case sketchy
    case vague
    case clear
    case closed
    case opened
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
    
    func hidePhysicsBody() {
        node?.isHidden = true
        for case let component as PhysicsComponent in components {
            return component.type = nil
        }
    }
    
    func showPhysicsBody() {
        node?.isHidden = false
        for case let component as PhysicsComponent in components {
            return component.type = .item
        }
    }
    
    init(withNode node: ItemNode, textures: [ItemTextureType: SKTexture], supportsAnimation: Bool = false) {
        guard let firstTexture = textures.first else { fatalError(.errorTextureNotFound) }
        
        super.init()
        addingComponents(node: node, supportsAnimation: supportsAnimation)
        // Important! First texture always run for the first time as a default texture.
        if node.texture == nil {
            node.run(SKAction.setTexture(firstTexture.value, resize: true))
        }
        if node.children.count > 0 {
            guard let bubbleNode = node.childNode(withName: "bubble") as? ItemNode else { return }
            node.infoBubble = InteractableItem(withNode: bubbleNode, textures: SharingItem.bubble.textures, supportsAnimation: true)
            node.infoBubble?.hidePhysicsBody()
        }
    }
    
    init(from renderableItem: any RenderableItem, at point: CGPoint, in scene: SKScene) {
        guard let node = renderableItem.generateNode(in: scene, with: nil) else {
            fatalError(.errorNodeNotFound)
        }
        super.init()
        addingComponents(node: node)
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    private func addingComponents(node: ItemNode, supportsAnimation: Bool = false) {
        let renderComponent = RenderComponent(node: node)
        let physicalComponent = PhysicsComponent(type: .item, renderComponent: renderComponent)
        
        addComponent(renderComponent)
        addComponent(physicalComponent)
        
        if supportsAnimation {
            let animationComponent = AnimationComponent(renderComponent: renderComponent)
            addComponent(animationComponent)
        }
    }
}
