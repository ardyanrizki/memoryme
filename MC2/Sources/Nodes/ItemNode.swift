//
//  ItemNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

class ItemNode: SKSpriteNode {
    var identifier: ItemIdentifier?
    
    var textures: [ItemTextureType: SKTexture]?
    
    var textureType: ItemTextureType?
    
    func createInteractableItem(in scene: SKScene, withTextureType textureType: ItemTextureType?) -> InteractableItem {
        guard let identifier, let node = identifier.getNode(from: scene, withTextureType: textureType) else { fatalError(.errorNodeNotFound) }
        let textures = identifier.getTextures()
        return InteractableItem(withNode: node, textures: textures)
    }
}
