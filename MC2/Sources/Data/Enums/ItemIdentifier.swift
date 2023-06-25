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
        switch self {
        case .laptop:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
        case .radio:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .vase:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.vase)
            ]
        case .bed:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .book:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .bookshelf:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .chair:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             */
            // Please delete `break` when this case line applied.
            break
        case .clothes:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             */
            // Please delete `break` when this case line applied.
            break
        case .curtain:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             */
            // Please delete `break` when this case line applied.
            break
        case .computer:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             */
            // Please delete `break` when this case line applied.
            break
        case .desk:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             */
            // Please delete `break` when this case line applied.
            break
        case .photoAlbum:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .pillow:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .wardrobe:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        case .window:
            /*
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.laptop)
            ]
             // Please delete `break` when this case line applied.
             */
            break
        }
        return textures
    }
}
