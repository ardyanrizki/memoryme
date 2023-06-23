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
    case item
}

struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
    static let wall: UInt32 = 0x1 << 2
    static let item: UInt32 = 0x1 << 3
}

class PhysicsComponent: GKComponent {
    
    public var physicsBody: SKPhysicsBody?
    
    private var characterVisualComponent: CharacterVisualComponent
    
    init(type: PhysicsType, characterVisualComponent: CharacterVisualComponent) {
        self.characterVisualComponent = characterVisualComponent
        super.init()
        setupPhysicsBody(for: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody(for type: PhysicsType) {
        let node = characterVisualComponent.node
        let physicsBody = SKPhysicsBody(rectangleOf: node.size)
        switch type {
        case .character:
            physicsBody.categoryBitMask = PhysicsCategory.character
            physicsBody.collisionBitMask = PhysicsCategory.obstacle | PhysicsCategory.wall
            physicsBody.contactTestBitMask = PhysicsCategory.item
            physicsBody.affectedByGravity = false
            physicsBody.isDynamic = true
        case .wall:
            physicsBody.categoryBitMask = PhysicsCategory.wall
            physicsBody.collisionBitMask = PhysicsCategory.character
            physicsBody.affectedByGravity = false
            physicsBody.isDynamic = false
        case .item:
            break
        }
        self.physicsBody = physicsBody
    }
}
