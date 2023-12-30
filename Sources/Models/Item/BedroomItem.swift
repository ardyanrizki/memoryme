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
            return .init(heightMultiplier: 0.8, 
                         textures: [.messy: SKTexture(imageNamed: TextureResources.bedMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .bedTidy:
            return .init(heightMultiplier: 0.8, 
                         textures: [.tidy: SKTexture(imageNamed: TextureResources.bedTidy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .book:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.booksMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .bookshelf:
            return .init(heightMultiplier: 0.8, 
                         textures: [.messy: SKTexture(imageNamed: TextureResources.bookshelfMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .bookshelfTidy:
            return .init(heightMultiplier: 0.8, 
                         textures: [.tidy: SKTexture(imageNamed: TextureResources.bookshelfTidy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .chair:
            return .init(heightMultiplier: 0.6,
                         textures: [.messy: SKTexture(imageNamed: TextureResources.chairMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .clothes:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.clothesMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .computer:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.computerMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .curtain:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.curtainMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .desk:
            return .init(heightMultiplier: 0.8,
                         textures: [.messy: SKTexture(imageNamed: TextureResources.deskMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .deskTidy:
            return .init(heightMultiplier: 0.6, 
                         textures: [.tidy: SKTexture(imageNamed: TextureResources.deskTidy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .photoAlbum:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.photoAlbum)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .pillow:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.pillowMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .wardrobe:
            return .init(heightMultiplier: 0.8,
                         textures: [.messy: SKTexture(imageNamed: TextureResources.wardrobeMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .wardrobeTidy:
            return .init(heightMultiplier: 0.8, textures: [.tidy: SKTexture(imageNamed: TextureResources.wardrobeTidy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .window:
            return .init(textures: [.messy: SKTexture(imageNamed: TextureResources.windowMessy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .windowTidy:
            return .init(textures: [.tidy: SKTexture(imageNamed: TextureResources.windowTidy)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
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
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?  {
        props.makePhysicsBody
    }
    
}
