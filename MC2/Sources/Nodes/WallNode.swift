//
//  WallNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class WallNode: SKNode {
    func setupPhysicsBodyCollision() {
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        physicsBody?.categoryBitMask = PhysicsCategory.wall
        physicsBody?.collisionBitMask = PhysicsCategory.character
    }
}
