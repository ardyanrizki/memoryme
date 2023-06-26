//
//  ItemIdentifier.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

enum ItemIdentifier: String, CaseIterable {
    // MARK: Items in Office
    case laptop = "laptop"
    case radio = "radio"
    case vase = "vase"
    // MARK: Items in Bedroom
    case bed = "bed"
    case book = "book"
    case bookshelf = "bookshelf"
    case chair = "chair"
    case clothes = "clothes"
    case curtain = "curtain"
    case computer = "computer"
    case desk = "desk"
    case photoAlbum = "photoAlbum"
    case pillow = "pillow"
    case wardrobe = "wardrobe"
    case window = "window"
    
    func getNode(from scene: SKScene) -> ItemNode? {
        let node = scene.childNode(withName: self.rawValue) as? ItemNode
        node?.identifier = self
        node?.name = self.rawValue
        node?.texture = getTextures().first?.value
        node?.zPosition = 1
        return node
    }
    
    /**
     Returns textures for this item's identifier.
     - WARNING: First texture always run for the first time as a default texture in `ItemNode`.
     */
    func getTextures() -> [ItemTextureType: SKTexture] {
        var textures = [ItemTextureType: SKTexture]()
        // TODO: Add item textures
        switch self {
        case .laptop:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
        case .radio:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.radio)
            ]
        case .vase:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.vase)
            ]
        case .bed:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.bedMessy),
                .messy: SKTexture(imageNamed: TextureResources.bedMessy)
            ]
        case .book:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.bookMessy)
            ]
        case .bookshelf:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.bookshelfTidy),
                .messy: SKTexture(imageNamed: TextureResources.bookshelfMessy)
            ]
        case .chair:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.chairMessy)
            ]
        case .clothes:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.clothesMessy)
            ]
        case .curtain:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.curtainMessy)
            ]
        case .computer:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.computerMessy)
            ]
        case .desk:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.deskTidy),
                .messy: SKTexture(imageNamed: TextureResources.deskMessy)
            ]
        case .photoAlbum:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.photoAlbum)
            ]
        case .pillow:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.pillowMessy)
            ]
        case .wardrobe:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.wardrobeTidy),
                .messy: SKTexture(imageNamed: TextureResources.wardrobeMessy)
            ]
        case .window:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.windowTidy),
                .messy: SKTexture(imageNamed: TextureResources.windowMessy)
            ]
        }
        return textures
    }
}
