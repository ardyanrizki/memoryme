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
        for case let component as CharacterVisualComponent in components {
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
        // MARK: Character Component
        let characterVisualComponent = CharacterVisualComponent(
            type: .mainCharacter,
            position: point,
            textures: textures
        )
        addComponent(characterVisualComponent)
        
        // MARK: Physics Component
        let physicsComponent = PhysicsComponent(type: .character, characterVisualComponent: characterVisualComponent)
        addComponent(physicsComponent)
        
        // MARK: Animation Component
        let animationComponent = AnimationComponent(characterVisualComponent: characterVisualComponent)
        addComponent(animationComponent)
        
        // MARK: Control Component
        let controlComponent = ControlComponent(characterVisualComponent: characterVisualComponent, animationComponent: animationComponent)
        addComponent(controlComponent)
    }
}
