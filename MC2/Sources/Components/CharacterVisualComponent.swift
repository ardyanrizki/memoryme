//
//  CharacterVisualComponent.swift
//  MC2
//
//  Created by Ivan on 18/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

enum CharacterType: String {
    case mainCharacter = "mainCharacter"
    case father = "father"
    case mother = "mother"
    case manager = "manager"
    case stranger = "stranger"
    case barista = "barista"
}

class CharacterVisualComponent: GKComponent {
    let characterNode: SKSpriteNode
    
    static func getTexture(type: CharacterType) -> String {
        switch type {
        case .mainCharacter:
            return "mory_walk_1"
        default:
            return ""
        }
    }
    
    init(type: CharacterType, position: CGPoint) {
        // load texture
        let texture = SKTexture(imageNamed: CharacterVisualComponent.getTexture(type: type))
        
        // create characterNode
        characterNode = SKSpriteNode(texture: texture)
        characterNode.position = position
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
