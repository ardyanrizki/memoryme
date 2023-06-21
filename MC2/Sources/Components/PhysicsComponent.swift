//
//  PhysicsComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

enum PhysicsType {
    case character
    case wall
}

struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
    static let wall: UInt32 = 0x1 << 2
    static let item: UInt32 = 0x1 << 3
}

class PhysicsComponent: GKComponent {
    var physicsBody: SKPhysicsBody
    
    static private func createPhysicsBody(node: SKSpriteNode, physicsType: PhysicsType) -> SKPhysicsBody {
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        
        switch physicsType {
        case .character:
            node.physicsBody?.categoryBitMask = PhysicsCategory.character
            node.physicsBody?.collisionBitMask = PhysicsCategory.obstacle | PhysicsCategory.wall
            node.physicsBody?.contactTestBitMask = PhysicsCategory.item
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = true
            
            break
        default:
            // TODO: define other physics body
            break
        }
        
        return node.physicsBody!
    }
    
    init(physicsType: PhysicsType, node: SKSpriteNode) {
        let newPhysicsBody: SKPhysicsBody = PhysicsComponent.createPhysicsBody(
            node: node,
            physicsType: physicsType
        )
        
        self.physicsBody = newPhysicsBody
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
