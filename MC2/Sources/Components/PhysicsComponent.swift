//
//  PhysicsComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

enum PhysicsType: UInt32 {
    case character = 0x1
    case item = 0x2
    case wall = 0x3
    case sceneChangeZone = 0x4
}

class PhysicsComponent: GKComponent {
    
    public var physicsBody: SKPhysicsBody?
    
    private var renderComponent: RenderComponent
    
    init(type: PhysicsType, renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        super.init()
        setupPhysicsBody(for: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    private func setupPhysicsBody(for type: PhysicsType, withSize size: CGSize? = nil) {
        let node = renderComponent.node
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        switch type {
        case .character:
            let physicsSize = CGSize(width: node.size.width / 1.2, height: node.size.height / 4)
            node.physicsBody = SKPhysicsBody(rectangleOf: physicsSize, center: CGPoint(x: 0, y: physicsSize.height / 2))
            node.physicsBody?.categoryBitMask = PhysicsType.character.rawValue
            node.physicsBody?.collisionBitMask = PhysicsType.item.rawValue | PhysicsType.wall.rawValue
            node.physicsBody?.contactTestBitMask = PhysicsType.item.rawValue
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.isDynamic = true
            node.zPosition = 1
        case .item:
            if let node = node as? ItemNode, let uniqueSize = node.identifier?.getSize() {
                node.physicsBody = SKPhysicsBody(rectangleOf: uniqueSize, center: CGPoint(x: 0, y: uniqueSize.height / 2))
            } else if let size {
                node.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: size.height / 2))
            } else {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
            }
            node.physicsBody?.categoryBitMask = PhysicsType.item.rawValue
            node.physicsBody?.collisionBitMask = PhysicsType.character.rawValue
            node.physicsBody?.contactTestBitMask = PhysicsType.item.rawValue
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = false
            node.zPosition = 2
        case .wall:
            break
        case .sceneChangeZone:
            break
        }
        
        self.physicsBody = node.physicsBody
    }
}
