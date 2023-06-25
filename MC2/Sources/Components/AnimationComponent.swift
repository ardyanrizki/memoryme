//
//  AnimationComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class AnimationComponent: GKComponent {
    
    var renderComponent: RenderComponent? {
        entity?.component(ofType: RenderComponent.self) as? RenderComponent
    }
    
    var characterVisualComponent: CharacterVisualComponent? {
        entity?.component(ofType: CharacterVisualComponent.self) as? CharacterVisualComponent
    }
    
    var animationKey: String?
    
    init(renderComponent: RenderComponent, characterVisualComponent: CharacterVisualComponent) {
//        self.renderComponent = renderComponent
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func animate(for state: AnimationState, timePerFrame time: TimeInterval = 0.3, withKey key: String) {
        guard let textures = characterVisualComponent?.textures[state], textures.count > 1 else {
            fatalError("Entity must have more than one texture to be animated")
        }
        animationKey = key
        let animationAction = SKAction.animate(with: textures, timePerFrame: time, resize: true, restore: true)
        let repeatedAnimation = SKAction.repeatForever(animationAction)
        renderComponent?.node.run(repeatedAnimation, withKey: key)
    }
    
    public func removeAnimation() {
        guard let animationKey else { return }
        renderComponent?.node.removeAction(forKey: animationKey)
        self.animationKey = nil
    }
    
    public func pauseAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent?.node.action(forKey: animationKey)
        animation?.speed = 0
    }
    
    public func resumePausedAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent?.node.action(forKey: animationKey)
        animation?.speed = 1
    }
}
