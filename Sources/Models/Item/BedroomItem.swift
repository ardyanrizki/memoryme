//
//  BedroomItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum BedroomItem: String {
    case bed
    case bedTidy
    case book
    case bookshelf
    case bookshelfTidy
    case chair
    case clothes
    case computer
    case curtain
    case desk
    case deskTidy
    case photoAlbum
    case pillow
    case wardrobe
    case wardrobeTidy
    case window
    case windowTidy
    
    var props: ItemProps {
        switch self {
        case .bed:
            return .init(heightMultiplier: 0.8, textures: [
                .messy: SKTexture(imageNamed: TextureResources.bedMessy)
            ])
        case .bedTidy:
            return .init(heightMultiplier: 0.8, textures: [
                .tidy: SKTexture(imageNamed: TextureResources.bedTidy)
            ])
        case .book:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.booksMessy)
            ])
        case .bookshelf:
            return .init(heightMultiplier: 0.8, textures: [
                .messy: SKTexture(imageNamed: TextureResources.bookshelfMessy)
            ])
        case .bookshelfTidy:
            return .init(heightMultiplier: 0.8, textures: [
                .tidy: SKTexture(imageNamed: TextureResources.bookshelfTidy)
            ])
        case .chair:
            return .init(heightMultiplier: 0.6, textures: [
                .messy: SKTexture(imageNamed: TextureResources.chairMessy)
            ])
        case .clothes:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.clothesMessy)
            ])
        case .computer:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.computerMessy)
            ])
        case .curtain:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.curtainMessy)
            ])
        case .desk:
            return .init(heightMultiplier: 0.8, textures: [
                .messy: SKTexture(imageNamed: TextureResources.deskMessy)
            ])
        case .deskTidy:
            return .init(heightMultiplier: 0.6, textures: [
                .tidy: SKTexture(imageNamed: TextureResources.deskTidy)
            ])
        case .photoAlbum:
            return .init(textures: [
                .normal: SKTexture(imageNamed: TextureResources.photoAlbum)
            ])
        case .pillow:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.pillowMessy)
            ])
        case .wardrobe:
            return .init(heightMultiplier: 0.8, textures: [
                .messy: SKTexture(imageNamed: TextureResources.wardrobeMessy)
            ])
        case .wardrobeTidy:
            return .init(heightMultiplier: 0.8, textures: [
                .tidy: SKTexture(imageNamed: TextureResources.wardrobeTidy)
            ])
        case .window:
            return .init(textures: [
                .messy: SKTexture(imageNamed: TextureResources.windowMessy)
            ])
        case .windowTidy:
            return .init(textures: [
                .tidy: SKTexture(imageNamed: TextureResources.windowTidy)
            ])
        }
    }
}

extension BedroomItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
}
