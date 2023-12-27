//
//  MovementComponent.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

/// ControlComponent manages the movement and behavior of a character entity.
class ControlComponent: GKComponent {
    
    /// The render component associated with the entity.
    private var renderComponent: RenderComponent
    
    /// The animation component responsible for character animations.
    private var animationComponent: AnimationComponent?
    
    /// The sound component responsible for character sounds.
    private var soundComponent: SoundComponent?
    
    /// The target location for the character to move towards.
    private var targetLocation: CGPoint?
    
    /// A closure to be executed upon completion of walking.
    private var walkingCompletion: (() -> Void)?
    
    /// The movement speed of the character.
    var moveSpeed: CGFloat = 300.0
    
    /// Initializes the control component with render, animation, and sound components.
    /// - Parameters:
    ///   - renderComponent: The render component associated with the entity.
    ///   - animationComponent: The animation component responsible for character animations.
    ///   - soundComponent: The sound component responsible for character sounds.
    init(
        renderComponent: RenderComponent,
        animationComponent: AnimationComponent?,
        soundComponent: SoundComponent
    ) {
        self.renderComponent = renderComponent
        super.init()
        self.animationComponent = animationComponent
        self.soundComponent = soundComponent
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    /// Updates the control component's state.
    /// - Parameter seconds: The time interval since the last update.
    override func update(deltaTime seconds: TimeInterval) {
        let node = renderComponent.node
        
        // Check if there is a target location to move towards
        if let targetLocation, (node.position - targetLocation).length() > 10 {
            // Character is walking
            animationComponent?.animate(
                for: .walk,
                timePerFrame: 0.2,
                withKey: CharacterAnimationState.walk.rawValue
            )
            
            // Play walking sound if available
            if let soundPlayer = soundComponent?.soundPlayer {
                soundPlayer.rate = 2.5
                soundPlayer.play()
            }
            
            // Move towards the target location
            let direction = (targetLocation - node.position).normalized()
            let movement = moveSpeed * CGFloat(seconds) * direction
            node.position += movement
            
            // Adjust character scale based on movement direction
            let scaleDirection: CGFloat = (direction.x < 0) ? 1.0 : -1.0
            node.xScale = abs(node.xScale) * scaleDirection
        } else {
            // On target location, stop walking
            if animationComponent?.animationKey == CharacterAnimationState.walk.rawValue {
                stopWalking()
            }
        }
    }
    
    /// Initiates walking towards a specific point with a given speed.
    /// - Parameters:
    ///   - point: The target point to walk towards.
    ///   - speed: The speed of the walking movement.
    ///   - completion: A closure to be executed upon completion of walking.
    public func walk(to point: CGPoint, speed: CGFloat = 300.0, completion: @escaping () -> Void) {
        targetLocation = CGPoint(x: point.x, y: point.y)
        moveSpeed = speed
        walkingCompletion = completion
    }
    
    /// Stops the walking movement and executes the walking completion closure.
    public func stopWalking() {
        targetLocation = nil
        animationComponent?.animate(
            for: .idle,
            timePerFrame: 0.6,
            withKey: CharacterAnimationState.idle.rawValue
        )
        
        // Stop walking sound if available
        if let soundPlayer = soundComponent?.soundPlayer {
            soundPlayer.stop()
        }
        
        // Execute walking completion closure
        walkingCompletion?()
        walkingCompletion = nil
    }
}
