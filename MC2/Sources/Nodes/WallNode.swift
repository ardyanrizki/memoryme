//
//  WallNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class WallNode: SKSpriteNode {
    func setupPhysicsBody() {
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        physicsBody?.categoryBitMask = PhysicsCategory.wall
        physicsBody?.collisionBitMask = PhysicsCategory.character
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        zPosition = 1
        alpha = 0
    }
}
