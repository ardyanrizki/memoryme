//
//  CharacterVisualComponent.swift
//  MC2
//
//  Created by Ivan on 18/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

enum EntityType: String {
    case mainCharacter = "mainCharacter"
    case father = "father"
    case mother = "mother"
    case manager = "manager"
    case stranger = "stranger"
    case barista = "barista"
    
    case vase = "vase"
}

class CharacterVisualComponent: GKComponent {
    
    let textures: [AnimationState: [SKTexture]]
    var state: AnimationState = .idle
    
    let renderComponent: RenderComponent
    
    init(type: EntityType, textures: [AnimationState: [SKTexture]], renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        self.textures = textures
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getTexture(type: EntityType) -> String {
        switch type {
        case .mainCharacter:
            return "mory_walk_1"
        default:
            return ""
        }
    }
}
