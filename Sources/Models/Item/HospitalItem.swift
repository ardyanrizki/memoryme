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
            return .init(heightMultiplier: 1,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.leftSofa)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .rightSofa:
            return .init(heightMultiplier: 1,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.rightSofa)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .trash:
            return .init(heightMultiplier: 1,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.trash)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
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
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?  {
        props.makePhysicsBody
    }
    
}
