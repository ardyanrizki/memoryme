//
//  OfficeItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum OfficeItem: String {
    case bookshelfOffice
    case bossDesk
    case macBook
    case officeChair
    case officeChairFlipped
    case officeDeskBehind
    case officeDeskFront
    case photoFrame
    case whiteboard
    
    private var props: ItemProps {
        switch self {
        case .bookshelfOffice:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.bookshelf)
            ])
        case .bossDesk:
            return .init(heightMultiplier: 0.8, textures: [
                .normal: SKTexture(imageNamed: TextureResources.bossDesk)
            ])
        case .macBook:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.macbook)
            ])
        case .officeChair:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.officeChair)
            ])
        case .officeChairFlipped:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.officeChairFlipped)
            ])
        case .officeDeskBehind:
            return .init(heightMultiplier: 0.6, textures: [
                .normal: SKTexture(imageNamed: TextureResources.officeDeskBehind)
            ])
        case .officeDeskFront:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.officeDeskFront)
            ])
        case .photoFrame:
            return .init(heightMultiplier: 1, textures: [
                .normal: SKTexture(imageNamed: TextureResources.photoframe)
            ])
        case .whiteboard:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.whiteboard)
            ])
        }
    }
}

extension OfficeItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
}
