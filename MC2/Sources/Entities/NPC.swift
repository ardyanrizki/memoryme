//
//  NPC.swift
//  MC2
//
//  Created by Rivan Mohammad Akbar on 03/07/23.
//

import SpriteKit
import GameplayKit

class NPC: GKEntity {
    
    var node: SKSpriteNode? {
        for case let component as RenderComponent in components {
            return component.node
        }
        return nil
    }
    
    init(at position: CGPoint, textures: [CharacterAnimationState: [SKTexture]]? = nil) {
        super.init()
        
        let textureName = TextureResources.bartenderCharacter
        
        let idleTextures = TextureResources.bartenderCharacterAtlasIdle.getAllTexturesFromAtlas()
        let walkTextures = TextureResources.bartenderCharacterAtlasWalk.getAllTexturesFromAtlas()
        var defaultTextures: [CharacterAnimationState: [SKTexture]] = [
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        if let textures {
            defaultTextures = textures
        }
        
        addingComponents(name: textureName, position: position, textures: defaultTextures)
        
        node?.zPosition = 15
        
        animate(for: .idle)
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    public func animate(for state: CharacterAnimationState) {
        for case let animationComponent as AnimationComponent in components {
            animationComponent.animate(for: state, timePerFrame: 0.6, withKey: state.rawValue)
        }
    }
    
    private func addingComponents(name: TextureName, position: CGPoint, textures: [CharacterAnimationState: [SKTexture]]) {
        let renderComponent = RenderComponent(with: name, at: position)
        addComponent(renderComponent)
        
        // MARK: Character Component
        let characterVisualComponent = CharacterVisualComponent(
            textures: textures,
            renderComponent: renderComponent
        )
        addComponent(characterVisualComponent)
        
        // MARK: Physics Component
        let physicsComponent = PhysicsComponent(type: .character, renderComponent: renderComponent)
        addComponent(physicsComponent)
        
        // MARK: Animation Component
        let animationComponent = AnimationComponent(renderComponent: renderComponent, characterVisualComponent: characterVisualComponent)
        addComponent(animationComponent)
    }
}
