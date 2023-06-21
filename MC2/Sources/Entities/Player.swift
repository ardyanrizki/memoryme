//
//  Player.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    static var textureSize = CGSize(width: 120.0, height: 120.0)
    
    var node: SKSpriteNode?
    
    init(position point: CGPoint) {
        super.init()
        addingComponents(position: point)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func walk(to point: CGPoint) {
        for case let controlComponent as ControlComponent in components {
            controlComponent.walk(to: point)
        }
    }
    
    private func addingComponents(position point: CGPoint) {
        let characterVisualComponent = CharacterVisualComponent(
            type: .mainCharacter,
            position: point
        )
        
        node = characterVisualComponent.characterNode
        
        guard let node else {
            print("Error: No player node available.")
            return
        }
        
        let physicalComponent = PhysicsComponent(
            physicsType: .character,
            node: node
        )
        
        let walkTextureAtlas = SKTextureAtlas(named: "MoryWalk")
        
        let walkTextures = walkTextureAtlas.textureNames.sorted().map {
            walkTextureAtlas.textureNamed($0)
        }
        
        let allTextures: [AnimationState: [SKTexture]] = [
            .walk: walkTextures
        ]
        
        let walkAnimationComponent = AnimationComponent(entityNode: node, frames: allTextures)
        
        addComponent(characterVisualComponent)
        addComponent(physicalComponent)
        addComponent(ControlComponent())
        addComponent(walkAnimationComponent)
        addComponent(MainPlayerComponent(playerNode: characterVisualComponent.characterNode))
    }
}
