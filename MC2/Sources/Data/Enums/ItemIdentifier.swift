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
    
    func getAllNodes(from scene: SKScene, zPosition: CGFloat = 1) -> [ItemNode] {
        var nodes = [ItemNode]()
        scene.children.forEach { node in
            guard let nodeName = node.name, nodeName.contains(self.rawValue) else { return }
            let splittedStr = nodeName.splitIdentifer()
            guard splittedStr.first(where: { $0 == self.rawValue }) != nil else { return }
            let textureType = splittedStr.compactMap { str in
                ItemTextureType.allCases.first(where: { $0.rawValue == str })
            }.first
            guard let node = scene.childNode(withName: nodeName) as? ItemNode else { return }
            node.identifier = self
            node.textures = getTextures()
            node.textureType = textureType ?? getTextures().first?.key
            node.texture = getTextures()[node.textureType ?? getTextures().first?.key ?? .normal]
            node.zPosition = zPosition
            nodes.append(node)
        }
        return nodes
    }
    
    func createNode(in scene: SKScene, withTextureType textureType: ItemTextureType?, zPosition: CGFloat = 1) -> ItemNode? {
        let node = scene.childNode(withName: self.rawValue) as? ItemNode
        node?.identifier = self
        node?.textures = getTextures()
        node?.textureType = textureType ?? getTextures().first?.key
        node?.name = self.rawValue
        node?.texture = node?.textures?[node?.textureType ?? .normal]
        node?.zPosition = zPosition
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
                .tidy: SKTexture(imageNamed: TextureResources.bedTidy),
                .messy: SKTexture(imageNamed: TextureResources.bedMessy)
            ]
        case .book:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.booksMessy)
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
    
    func getSize() -> CGSize? {
        guard let size = getTextures().first?.value.size() else { return nil }
        switch self {
        case .laptop:
            return CGSize(width: size.width, height: size.height)
        case .radio:
            return nil
        case .vase:
            return nil
        case .bed:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .book:
            return nil
        case .bookshelf:
            return nil
        case .chair:
            return nil
        case .clothes:
            return nil
        case .curtain:
            return nil
        case .computer:
            return nil
        case .desk:
            return nil
        case .photoAlbum:
            return nil
        case .pillow:
            return nil
        case .wardrobe:
            return nil
        case .window:
            return nil
        }
    }
}
