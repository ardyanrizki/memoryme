//
//  RenderComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

enum ItemType: String {
    case vase = "vase"
    case photoAlbum = "photoAlbum"
}

class RenderComponent: GKComponent {
    let itemNode: SKSpriteNode
    
    static func getTexture(type: ItemType) -> String {
        switch type {
        case .vase:
            return "VaseDefault"
        case .photoAlbum:
            return "PhotoAlbum"
        default:
            return ""
        }
    }
    
    init(type: ItemType, position: CGPoint) {
        // load texture
        let texture = SKTexture(imageNamed: RenderComponent.getTexture(type: type))
        
        // create characterNode
        itemNode = SKSpriteNode(texture: texture)
        itemNode.position = position
        
        super.init()
    }
    
    init(node: SKSpriteNode, position: CGPoint? = nil) {
        itemNode = node
        
        if let position {
            itemNode.position = position
        }
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
