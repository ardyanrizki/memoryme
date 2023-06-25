//
//  ItemNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

class ItemNode: SKSpriteNode {
    var identifier: ItemIdentifier?
    
    func createInteractiveItem(from scene: SKScene) -> InteractiveItem {
        guard let identifier, let node = identifier.getNode(from: scene) else { fatalError("Node unavailable.") }
        let textures = identifier.getTextures()
        return InteractiveItem(from: node, textures: textures)
    }
}
