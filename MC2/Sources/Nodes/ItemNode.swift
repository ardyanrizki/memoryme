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
    
    func createInteractableItem() -> InteractableItem {
        guard let textures else { fatalError(.errorTextureNotFound) }
        return InteractableItem(withNode: self, textures: textures)
    }
}
