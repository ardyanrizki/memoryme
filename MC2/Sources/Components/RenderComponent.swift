//
//  RenderComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
    
    let node: SKSpriteNode
    
    static func getTexture(type: EntityType) -> String {
        switch type {
        case .vase:
            return "VaseDefault"
        default:
            return ""
        }
        
    }
    
    init(type: EntityType, position: CGPoint) {
        // load texture
        let texture = SKTexture(imageNamed: RenderComponent.getTexture(type: type))
        
        // create characterNode
        node = SKSpriteNode(texture: texture)
        node.position = position
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
