//
//  MovementComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class ControlComponent: GKComponent {
    var mainPlayereComponent: MainPlayerComponent? {
        return entity?.component(ofType: MainPlayerComponent.self)
    }
    
    var animationComponent: AnimationComponent? {
        return entity?.component(ofType: AnimationComponent.self)
    }
    
    // buat ngepasin touch point dengan kaki karakter
    let offsetY: Double = 80.0
    
    public func walk(to point: CGPoint) {
        if let node = self.mainPlayereComponent?.playerNode {
            var multipleForDirection: CGFloat
            
            // screen width divided by 3, so the bear will be able to travel the width of the scene in 3 seconds.
            let playerSpeed = 300.0
            
            // compare previous location vs future location and get the difference
            let moveDifference = CGPoint(x: point.x - node.position.x, y: point.y - node.position.y)
            let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
            
            // get how long it should take the bear to move along this length, by dividing the length by desired speed
            let moveDuration = distanceToMove / playerSpeed
            
            // Flip direction
            if moveDifference.x < 0 {
                multipleForDirection = 1.0
            } else {
                multipleForDirection = -1.0
            }
            
            node.xScale = abs(node.xScale) * multipleForDirection
            
            // Start the legs moving on your bear if he is not already moving his legs.
            if node.action(forKey: "walking") == nil {
              // if legs are not moving, start them
                animationComponent?.startAnimation(state: .walk)
            }
            
            let newPoint = CGPoint(x: point.x, y: point.y + offsetY)
            
            // Create a move action specifying where to move and how long it should take.
            let moveAction = SKAction.move(to: newPoint, duration:(TimeInterval(moveDuration)))

            // Create a done action that will run a block to stop the animation
            let doneAction = SKAction.run({
                node.removeAllActions()
            })

            // 4
            let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
            node.run(moveActionWithDone, withKey: "walking")
        }
    }
}
