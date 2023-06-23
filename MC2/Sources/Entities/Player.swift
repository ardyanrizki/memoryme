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
    
    init(position point: CGPoint, textures: [AnimationState: [SKTexture]]) {
        super.init()
        addingComponents(position: point, textures: textures)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func walk(to point: CGPoint) {
        for case let controlComponent as ControlComponent in components {
            controlComponent.walk(to: point)
        }
    }
    
    private func addingComponents(position point: CGPoint, textures: [AnimationState: [SKTexture]]) {
        let renderComponent = RenderComponent(type: .mainCharacter, position: point)
        addComponent(renderComponent)
        
        // MARK: Character Component
        let characterVisualComponent = CharacterVisualComponent(
            type: .mainCharacter,
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
        let controlComponent = ControlComponent(characterVisualComponent: characterVisualComponent, renderComponent: renderComponent, animationComponent: animationComponent)
        addComponent(controlComponent)
    }
}
