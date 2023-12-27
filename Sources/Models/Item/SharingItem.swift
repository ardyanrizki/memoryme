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
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.bubble1)
            ])
        case .lowerDoor:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.lowerDoor)
            ])
        case .sideDoor:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.sideDoor)
            ])
        case .upperDoor:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.upperDoor),
                .sketchy: SKTexture(imageNamed: TextureResources.upperDoorSketchy),
                .vague: SKTexture(imageNamed: TextureResources.upperDoorVague),
                .clear: SKTexture(imageNamed: TextureResources.upperDoorClear)
            ])
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
    
}
