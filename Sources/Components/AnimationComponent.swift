//
//  AnimationComponent.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

/// AnimationComponent manages animations.
class AnimationComponent: GKComponent {
    
    /// The render component associated with the entity.
    var renderComponent: RenderComponent
    
    /// The visual component responsible for character appearance.
    var characterVisualComponent: CharacterVisualComponent?
    
    /// The key used to identify the current animation.
    var animationKey: String?
    
    /// Initializes the animation component with a render component and an optional character visual component.
    init(renderComponent: RenderComponent, characterVisualComponent: CharacterVisualComponent? = nil) {
        self.renderComponent = renderComponent
        self.characterVisualComponent = characterVisualComponent
        super.init()
    }
    
    /// Initializes the animation component with a render component.
    init(renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    /// Animates the character for a specific state with customizable options.
    /// - Parameters:
    ///   - state: The animation state to transition to.
    ///   - time: The time per frame for the animation.
    ///   - key: The key to identify the animation. If nil, the raw value of the animation state is used.
    ///   - isRepeatForever: Indicates whether the animation should repeat forever.
    ///   - repeatCount: The number of times the animation should repeat if not forever.
    ///   - completion: A closure called upon completion of the animation.
    public func animate(
        for state: CharacterAnimationState,
        timePerFrame time: TimeInterval = 0.3,
        withKey key: String? = nil,
        isRepeatForever: Bool = true,
        repeatCount: Int = 1,
        completion: ((_ key: String?) -> Void)? = nil
    ) {
        guard animationKey != key else { return }
        removeAnimation()
        guard let textures = characterVisualComponent?.textures[state], textures.count > 1 else {
            fatalError(.errorTextureNotFound)
        }
        animationKey = key ?? state.rawValue
        let animationAction = SKAction.animate(with: textures, timePerFrame: time, resize: true, restore: true)
        let repeatableAction: SKAction
        if isRepeatForever {
            repeatableAction = SKAction.repeatForever(animationAction)
        } else {
            let mainAction = SKAction.repeat(animationAction, count: repeatCount)
            let completionAction = SKAction.run {
                completion?(self.animationKey)
            }
            repeatableAction = SKAction.sequence([mainAction, completionAction])
        }
        renderComponent.node.run(repeatableAction, withKey: animationKey ?? state.rawValue)
    }
    
    /// Animates the character with a custom SKAction.
    /// - Parameters:
    ///   - action: The SKAction to animate the character.
    ///   - completion: A closure called upon completion of the animation.
    public func animate(_ action: SKAction, completion: @escaping () -> Void = { }) {
        renderComponent.node.run(action, completion: completion)
    }
    
    /// Animates the character with specified textures and key.
    /// - Parameters:
    ///   - textures: The textures to use for the animation.
    ///   - time: The time per frame for the animation.
    ///   - key: The key to identify the animation.
    public func animate(withTextures textures: [SKTexture], timePerFrame time: TimeInterval = 0.3, withKey key: String) {
        guard animationKey != key else { return }
        removeAnimation()
        animationKey = key
        let animationAction = SKAction.animate(with: textures, timePerFrame: time, resize: true, restore: true)
        let repeatedAnimation = SKAction.repeatForever(animationAction)
        renderComponent.node.run(repeatedAnimation, withKey: key)
    }
    
    /// Removes the current animation.
    public func removeAnimation() {
        guard let animationKey else { return }
        renderComponent.node.removeAction(forKey: animationKey)
        self.animationKey = nil
    }
    
    /// Removes a specific animation identified by its key.
    /// - Parameter key: The key identifying the animation to remove.
    public func removeAnimation(withKey key: String) {
        renderComponent.node.removeAction(forKey: key)
        if animationKey == key { animationKey = nil }
    }
    
    /// Pauses the current animation.
    public func pauseAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent.node.action(forKey: animationKey)
        animation?.speed = 0
    }
    
    /// Resumes a paused animation.
    public func resumePausedAnimation() {
        guard let animationKey else { return }
        let animation = renderComponent.node.action(forKey: animationKey)
        animation?.speed = 1
    }
}
