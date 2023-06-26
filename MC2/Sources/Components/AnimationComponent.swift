//
//  AnimationComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
    
    var renderComponent: RenderComponent
    
    var characterVisualComponent: CharacterVisualComponent
    
    var animationKey: String?
    
    init(renderComponent: RenderComponent, characterVisualComponent: CharacterVisualComponent) {
        self.renderComponent = renderComponent
        self.characterVisualComponent = characterVisualComponent
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    public func animate(for state: AnimationState, timePerFrame time: TimeInterval = 0.3, withKey key: String? = nil) {
        guard animationKey != key else { return }
        removeAnimation()
        guard let textures = characterVisualComponent.textures[state], textures.count > 1 else { fatalError(.errorTextureNotFound) }
        animationKey = key ?? state.rawValue
        let animationAction = SKAction.animate(with: textures, timePerFrame: time, resize: true, restore: true)
        let repeatedAnimation = SKAction.repeatForever(animationAction)
        renderComponent.node.run(repeatedAnimation, withKey: key ?? state.rawValue)
    }
    
    public func removeAnimation() {
        guard let animationKey else { return }
        renderComponent.node.removeAction(forKey: animationKey)
        self.animationKey = nil
    }
    
    public func removeAnimation(withKey key: String) {
        renderComponent.node.removeAction(forKey: key)
        if animationKey == key { animationKey = nil }
    }
    
    public func pauseAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent.node.action(forKey: animationKey)
        animation?.speed = 0
    }
    
    public func resumePausedAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent.node.action(forKey: animationKey)
        animation?.speed = 1
    }
}
