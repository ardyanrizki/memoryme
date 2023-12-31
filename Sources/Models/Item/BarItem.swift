//
//  BarItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum BarItem: String {
    case barIslandLeft
    case barIslandRight
    case radioBar
    case stool
    case stool2
    case stool3
    case tableAndChairs
    case tableAndChairs2
    case tableAndChairs3
    case wallPot
    
    var props: ItemProps {
        switch self {
        case .barIslandLeft:
            return .init(heightMultiplier: 0.6, textures: [
                .normal : SKTexture(imageNamed: TextureResources.barIslandLeft)
            ])
        case .barIslandRight:
            return .init(heightMultiplier: 0.9, textures: [
                .normal : SKTexture(imageNamed: TextureResources.barIslandRight)
            ])
        case .radioBar:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.radioBar)
            ])
        case .stool:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.stool)
            ])
        case .stool2:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.stool)
            ])
        case .stool3:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.stool)
            ])
        case .tableAndChairs:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.tableAndChairs)
            ])
        case .tableAndChairs2:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.tableAndChairs)
            ])
        case .tableAndChairs3:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.tableAndChairs)
            ])
        case .wallPot:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.wallPot)
            ])
        }
    }
}

extension BarItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
}
