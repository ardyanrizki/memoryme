//
//  HospitalItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum HospitalItem: String {
    case leftSofa
    case rightSofa
    case trash
    
    var props: ItemProps {
        switch self {
        case .leftSofa:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.leftSofa)
            ])
        case .rightSofa:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.rightSofa)
            ])
        case .trash:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.trash)
            ])
        }
    }
}

extension HospitalItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
}
