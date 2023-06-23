//
//  MovementComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class ControlComponent: GKComponent {
    private let offsetY: Double = 80.0
    
    private var renderComponent: RenderComponent
    private var animationComponent: AnimationComponent?
    
    init(characterVisualComponent: CharacterVisualComponent, renderComponent: RenderComponent, animationComponent: AnimationComponent?) {
        self.renderComponent = renderComponent
        super.init()
        self.animationComponent = animationComponent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func walk(to point: CGPoint, speed: CGFloat = 300.0, withKey key: String = "walking") {
        if renderComponent.node.action(forKey: key) == nil {
            let node = renderComponent.node
            var multipleForDirection: CGFloat
            
            // Compare previous location vs future location and get the difference
            let moveDifference = CGPoint(x: point.x - node.position.x, y: point.y - node.position.y)
            let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
            
            // Get how long it should take the bear to move along this length, by dividing the length by desired speed
            let moveDuration = distanceToMove / speed
            
            // Flip direction
            if moveDifference.x < 0 {
                multipleForDirection = 1.0
            } else {
                multipleForDirection = -1.0
            }
            
            node.xScale = abs(node.xScale) * multipleForDirection
            
            let newPoint = CGPoint(x: point.x, y: point.y + offsetY)
            
            // Create a move action specifying where to move and how long it should take.
            let moveAction = SKAction.move(to: newPoint, duration:(TimeInterval(moveDuration)))
            
            animationComponent?.animate(for: .walk, withKey: key)
            
            // Create a done action that will run a block to stop the animation
            let doneAction = SKAction.run({
                node.removeAllActions()
            })
            
            let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
            node.run(moveActionWithDone)
        }
    }
}
