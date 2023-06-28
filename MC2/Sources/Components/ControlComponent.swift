//
//  MovementComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class ControlComponent: GKComponent {
    
    private var renderComponent: RenderComponent
    private var animationComponent: AnimationComponent?
    
    private var targetLocation: CGPoint?
    
    var moveSpeed: CGFloat = 300.0
    
    init(renderComponent: RenderComponent, animationComponent: AnimationComponent?) {
        self.renderComponent = renderComponent
        super.init()
        self.animationComponent = animationComponent
    }
    
    required init?(coder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        let node = renderComponent.node
        if let targetLocation, (node.position - targetLocation).length() > 10 {
            animationComponent?.animate(for: .walk, timePerFrame: 0.2, withKey: Constants.walkingAction)
            let direction = (targetLocation - node.position).normalized()
            let movement = moveSpeed * seconds * direction
            node.position += movement
            
            var multipleForDirection: CGFloat
            if direction.x < 0 {
                multipleForDirection = 1.0
            } else {
                multipleForDirection = -1.0
            }
            node.xScale = abs(node.xScale) * multipleForDirection
        } else {
            // On target location
            if animationComponent?.animationKey == Constants.walkingAction {
                stopWalking()
            }
        }
    }
    
    public func walk(to point: CGPoint, speed: CGFloat = 300.0) {
        targetLocation  = CGPoint(x: point.x, y: point.y)
        moveSpeed = speed
    }
    
    public func stopWalking() {
        targetLocation = nil
        self.animationComponent?.animate(for: .idle, timePerFrame: 0.6, withKey: Constants.idleAction)
    }
}
