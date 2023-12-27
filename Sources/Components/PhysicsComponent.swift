//
//  PhysicsComponent.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

/// Enumeration representing different types of physics categories.
enum PhysicsType: UInt32 {
    case character = 0x1
    case item = 0x2
    case wall = 0x3
    case sceneChangeZone = 0x4
}

/// PhysicsComponent manages the physics behavior of an entity.
class PhysicsComponent: GKComponent {
    
    /// The type of physics for the entity.
    public var type: PhysicsType? {
        didSet {
            if let type {
                setupPhysicsBody(for: type)
            } else {
                renderComponent.node.physicsBody = nil
            }
        }
    }
    
    /// The render component associated with the entity.
    private var renderComponent: RenderComponent
    
    /// Initializes the physics component with a specified type and render component.
    /// - Parameters:
    ///   - type: The type of physics for the entity.
    ///   - renderComponent: The render component associated with the entity.
    init(type: PhysicsType, renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        super.init()
        setupPhysicsBody(for: type)
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
    
    /// Sets up the physics body for the entity based on its type.
    /// - Parameters:
    ///   - type: The type of physics for the entity.
    ///   - size: The size of the physics body (optional).
    private func setupPhysicsBody(for type: PhysicsType, withSize size: CGSize? = nil) {
        let node = renderComponent.node
        
        switch type {
        case .character:
            node.anchorPoint = CGPoint(x: 0.5, y: 0)
            let physicsSize = CGSize(width: node.size.width / 1.2, height: node.size.height / 4)
            node.anchorPoint = CGPoint(x: 0.5, y: 0)
            node.physicsBody = SKPhysicsBody(rectangleOf: physicsSize, center: CGPoint(x: 0, y: physicsSize.height / 2))
            configurePhysicsBody(of: node, for: .character)
        case .item:
            if let node = node as? ItemNode, let uniqueSize = node.renderableItem?.size {
                let yPoint = uniqueSize.height > node.size.height ? (abs(uniqueSize.height - node.size.height) / 2) : -(node.size.height / 2) + (uniqueSize.height / 2)
                node.physicsBody = SKPhysicsBody(rectangleOf: uniqueSize, center: CGPoint(x: 0, y: yPoint))
                configurePhysicsBody(of: node, for: .item)
                configureItemZPosition(node)
            } else if let size {
                node.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: 0, y: size.height / 2))
                configurePhysicsBody(of: node, for: .item)
            } else {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                configurePhysicsBody(of: node, for: .item)
                configureItemZPosition(node)
            }
        case .wall, .sceneChangeZone:
            break
        }
    }
    
    /// Configures the physics body properties for a given type.
    /// - Parameters:
    ///   - node: The item node.
    ///   - type: The type of physics for the entity.
    private func configurePhysicsBody(of node: SKSpriteNode, for type: PhysicsType) {
        node.physicsBody?.categoryBitMask = type.rawValue
        node.physicsBody?.collisionBitMask = (type == .character) ? PhysicsType.item.rawValue | PhysicsType.wall.rawValue : PhysicsType.character.rawValue
        node.physicsBody?.contactTestBitMask = PhysicsType.item.rawValue
        node.physicsBody?.affectedByGravity = (type == .character) ? false : false
        node.physicsBody?.allowsRotation = (type == .character) ? false : false
        node.physicsBody?.isDynamic = (type == .character) ? true : false
        node.zPosition = (type == .character) ? 15 : (type == .item) ? 4 : 0
    }
    
    /// Configures the Z position of an item node based on its name.
    /// - Parameter node: The item node.
    private func configureItemZPosition(_ node: SKSpriteNode) {
        if node.name == OfficeItem.macBook.rawValue || node.name == OfficeItem.photoFrame.rawValue {
            node.zPosition = 4
        } else if node.name == BarItem.radioBar.rawValue {
            node.zPosition = 25
        } else {
            node.zPosition = 2
        }
    }
}
