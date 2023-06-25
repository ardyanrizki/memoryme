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
    case sceneChangeZone
}

struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 0
    static let obstacle: UInt32 = 0x1 << 1
    static let wall: UInt32 = 0x1 << 2
    static let item: UInt32 = 0x1 << 3
    static let sceneChangeZone: UInt32 = 0x1 << 4
}

class PhysicsComponent: GKComponent {
    
    public var physicsBody: SKPhysicsBody?

    static private func createPhysicsBody(node: SKSpriteNode, physicsType: PhysicsType) -> SKPhysicsBody {
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        
        switch physicsType {
        case .character:
            let size = CGSize(width: node.size.width, height: node.size.height / 2)
            node.physicsBody = SKPhysicsBody(rectangleOf: size)
//            node.anchorPoint = CGPoint(x: 0, y: 0)
            node.position.y -= node.size.height / 2
            node.physicsBody?.categoryBitMask = PhysicsCategory.character
            node.physicsBody?.collisionBitMask = PhysicsCategory.obstacle | PhysicsCategory.wall | PhysicsCategory.item
            node.physicsBody?.contactTestBitMask = PhysicsCategory.item
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.isDynamic = true
        case .item:
            node.physicsBody?.categoryBitMask = PhysicsCategory.item
            node.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle | PhysicsCategory.wall
            node.physicsBody?.contactTestBitMask = PhysicsCategory.item
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = false
        default:
            // TODO: define other physics body
            break
        }
        
        return node.physicsBody!
    }
    
    private var renderComponent: RenderComponent
    
    init(type: PhysicsType, renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        super.init()
        setupPhysicsBody(for: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysicsBody(for type: PhysicsType) {
        let node = renderComponent.node
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        switch type {
        case .character:
            node.physicsBody?.categoryBitMask = PhysicsCategory.character
            node.physicsBody?.collisionBitMask = PhysicsCategory.obstacle | PhysicsCategory.wall
            node.physicsBody?.contactTestBitMask = PhysicsCategory.item
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.isDynamic = true
        case .wall:
            node.physicsBody?.categoryBitMask = PhysicsCategory.wall
            node.physicsBody?.collisionBitMask = PhysicsCategory.character
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = false
        case .item:
            node.physicsBody?.categoryBitMask = PhysicsCategory.item
            node.physicsBody?.collisionBitMask = PhysicsCategory.character | PhysicsCategory.obstacle | PhysicsCategory.wall
            node.physicsBody?.contactTestBitMask = PhysicsCategory.item
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = false
        case .sceneChangeZone:
            break
        }
        self.physicsBody = node.physicsBody
    }
}
