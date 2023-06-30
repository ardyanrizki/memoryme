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
        physicsBody?.categoryBitMask = PhysicsType.wall.rawValue
        physicsBody?.collisionBitMask = PhysicsType.character.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
#if DEBUG
        color = .red
        alpha = 0.5
#else
        alpha = 0
#endif
    }
}
