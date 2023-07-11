//
//  Player.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class Character: GKEntity {
    
    var node: SKSpriteNode? {
        for case let component as RenderComponent in components {
            return component.node
        }
        return nil
    }
    
    init(at position: CGPoint, textures: [CharacterAnimationState: [SKTexture]]) {
        super.init()
        addingComponents(position: position, textures: textures)
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
    
    public func lay(completion: @escaping () -> Void = { }) {
        for case let animationComponent as AnimationComponent in components {
            animationComponent.animate(for: .lay, timePerFrame: 0.6, withKey: CharacterAnimationState.lay.rawValue, isRepeatForever: false) { key in
                self.animate(for: .idle)
                completion()
            }
        }
    }
    
    public func walk(to point: CGPoint) {
        for case let controlComponent as ControlComponent in components {
            controlComponent.walk(to: point)
        }
    }
    
    public func stopWalking() {
        for case let controlComponent as ControlComponent in components {
            controlComponent.stopWalking()
        }
    }
    
    private func addingComponents(position: CGPoint, textures: [CharacterAnimationState: [SKTexture]]) {
        guard let staticTexture = textures[.static]?.first ?? textures[.idle]?.first else { fatalError(.errorTextureNotFound) }
        
        let renderComponent = RenderComponent(with: staticTexture, at: position)
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
        
        let walkingSoundComponent = SoundComponent(soundFile: Constants.footSteps)
        
        // MARK: Animation Component
        let animationComponent = AnimationComponent(renderComponent: renderComponent, characterVisualComponent: characterVisualComponent)
        addComponent(animationComponent)
        
        // MARK: Control Component
        let controlComponent = ControlComponent(
            renderComponent: renderComponent,
            animationComponent: animationComponent,
            soundComponent: walkingSoundComponent
        )
        addComponent(controlComponent)
    }
}
