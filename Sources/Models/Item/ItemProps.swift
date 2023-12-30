//
//  ItemProps.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

/// A structure representing properties of an item, including textures and size.
struct ItemProps {
    /// Dictionary mapping item texture types to corresponding textures.
    let textures: [ItemTextureType: SKTexture]
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?
    
    /// Optional size of the item. If `nil`, the size is not explicitly set.
    var size: CGSize?

    /// Initializes an `ItemProps` with specified parameters.
    ///
    /// - Parameters:
    ///   - widthMultiplier: A multiplier for the width of the item's size. Defaults to `1`.
    ///   - heightMultiplier: A multiplier for the height of the item's size.
    ///   - textures: Dictionary mapping item texture types to corresponding textures.
    init(widthMultiplier: CGFloat = 1, heightMultiplier: CGFloat, textures: [ItemTextureType: SKTexture], makePhysicsBody: @escaping (ItemNode) -> SKPhysicsBody?) {
        self.textures = textures
        self.makePhysicsBody = makePhysicsBody
        self.size = calculateSize(widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier)
    }

    /// Initializes an `ItemProps` without explicitly setting the size.
    ///
    /// - Parameter textures: Dictionary mapping item texture types to corresponding textures.
    init(textures: [ItemTextureType: SKTexture], size: CGSize? = nil, makePhysicsBody: @escaping (ItemNode) -> SKPhysicsBody?) {
        self.textures = textures
        self.makePhysicsBody = makePhysicsBody
        self.size = size
    }

    /// Calculates the size of the item based on provided multipliers.
    ///
    /// - Parameters:
    ///   - widthMultiplier: A multiplier for the width of the item's size.
    ///   - heightMultiplier: A multiplier for the height of the item's size.
    /// - Returns: The calculated size of the item.
    func calculateSize(widthMultiplier: CGFloat, heightMultiplier: CGFloat) -> CGSize? {
        guard let size = textures.first?.value.size() else { return nil }
        return CGSize(width: size.width * widthMultiplier, height: size.height * heightMultiplier)
    }
}
