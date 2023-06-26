//
//  Player.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    static var textureSize = CGSize(width: 120.0, height: 120.0)
    
    var node: SKSpriteNode? {
        for case let component as RenderComponent in components {
            return component.node
        }
        return nil
    }
    
    init(at position: CGPoint, textures: [AnimationState: [SKTexture]]? = nil) {
        super.init()
        
        let name = TextureResources.mainCharacter
        
        let idleTextures = TextureResources.mainCharacterAtlasIdle.getAllTexturesFromAtlas()
        let walkTextures = TextureResources.mainCharacterAtlasWalk.getAllTexturesFromAtlas()
        var defaultTextures: [AnimationState: [SKTexture]] = [
            .walk: walkTextures,
            .idle: idleTextures
        ]
        if let textures {
            defaultTextures = textures
        }
        
        addingComponents(name: name, position: position, textures: defaultTextures)
        
        node?.zPosition = 2
        
        animate(for: .idle)
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    public func animate(for state: AnimationState) {
        for case let controlComponent as AnimationComponent in components {
            controlComponent.animate(for: state, timePerFrame: 0.6, withKey: "idle")
        }
    }
    
    public func walk(to point: CGPoint) {
        for case let controlComponent as ControlComponent in components {
            controlComponent.walk(to: point)
        }
    }
    
    private func addingComponents(name: TextureName, position: CGPoint, textures: [AnimationState: [SKTexture]]) {
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
        
        // MARK: Control Component
        let controlComponent = ControlComponent(renderComponent: renderComponent, animationComponent: animationComponent)
        addComponent(controlComponent)
    }
}
