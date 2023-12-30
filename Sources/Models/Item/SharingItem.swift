//
//  SharingItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum SharingItem: String {
    case bubble
    case lowerDoor
    case sideDoor
    case upperDoor
    
    var props: ItemProps {
        switch self {
        case .bubble:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.bubble1)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .lowerDoor:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.lowerDoor)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .sideDoor:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.sideDoor)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .upperDoor:
            return .init(heightMultiplier: 1, 
                         textures: [
                            .normal: SKTexture(imageNamed: TextureResources.upperDoor),
                            .sketchy: SKTexture(imageNamed: TextureResources.upperDoorSketchy),
                            .vague: SKTexture(imageNamed: TextureResources.upperDoorVague),
                            .clear: SKTexture(imageNamed: TextureResources.upperDoorClear)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        }
    }
}

extension SharingItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?  {
        props.makePhysicsBody
    }
    
}
