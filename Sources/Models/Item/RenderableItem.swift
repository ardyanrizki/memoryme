//
//  RenderableItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

/// A protocol defining the rendering behavior for items in a SpriteKit scene.
protocol RenderableItem: CaseIterable, Equatable where Self: RawRepresentable, Self.RawValue == String {
    
    /// Retrieves the textures associated with the item.
    var textures: [ItemTextureType: SKTexture] { get }
    
    /// Retrieves the size of the item.
    var size: CGSize? { get }
    
    /// Retrieves all nodes of the item type from the specified scene.
    ///
    /// - Parameters:
    ///   - scene: The SpriteKit scene to search for nodes.
    ///   - setZPosition: The z-position to assign to the retrieved nodes.
    /// - Returns: An array of `ItemNode` instances found in the scene.
    func findNodes(from scene: SKScene, setZPosition zPosition: CGFloat) -> [ItemNode]
    
    /// Creates a new node for the item in the specified scene.
    ///
    /// - Parameters:
    ///   - scene: The SpriteKit scene where the new node will be created.
    ///   - textureType: The type of texture to apply to the new node.
    ///   - setZPosition: The z-position to assign to the new node.
    /// - Returns: An optional `ItemNode` instance created in the scene.
    func generateNode(in scene: SKScene, with textureType: ItemTextureType?, setZPosition zPosition: CGFloat) -> ItemNode?
}

extension RenderableItem {
    
    /// Retrieves all nodes of the item type from the specified scene.
    ///
    /// - Parameters:
    ///   - scene: The SpriteKit scene to search for nodes.
    ///   - setZPosition: The z-position to assign to the retrieved nodes.
    /// - Returns: An array of `ItemNode` instances found in the scene.
    func findNodes(from scene: SKScene, setZPosition zPosition: CGFloat = 1) -> [ItemNode] {
        var nodes = [ItemNode]()
        
        scene.children.forEach { node in
            guard let nodeRawName = node.name, nodeRawName.contains(rawValue) else { return }
            
            let splittedStr = nodeRawName.splitIdentifier()
            guard let nodeName = splittedStr.first(where: { $0 == rawValue }) else { return }
            
            let textureType = splittedStr.compactMap { str in
                ItemTextureType.allCases.first { $0.rawValue == str }
            }.first
            
            guard let itemNode = node as? ItemNode else { return }
            
            itemNode.renderableItem = self
            itemNode.name = nodeName
            itemNode.textures = textures
            itemNode.textureType = textureType ?? textures.first?.key
            
            if let type = itemNode.textureType ?? textures.first?.key, let texture = textures[type] {
                itemNode.run(SKAction.setTexture(texture, resize: true))
            }
            
            itemNode.zPosition = zPosition
            nodes.append(itemNode)
        }
        
        return nodes
    }
    
    /// Creates a new node for the item in the specified scene.
    ///
    /// - Parameters:
    ///   - scene: The SpriteKit scene where the new node will be created.
    ///   - textureType: The type of texture to apply to the new node.
    ///   - setZPosition: The z-position to assign to the new node.
    /// - Returns: An optional `ItemNode` instance created in the scene.
    func generateNode(in scene: SKScene, with textureType: ItemTextureType?, setZPosition zPosition: CGFloat = 1) -> ItemNode? {
        guard let itemNode = scene.childNode(withName: rawValue) as? ItemNode else { return nil }
        
        itemNode.renderableItem = self
        itemNode.textures = textures
        itemNode.textureType = textureType ?? textures.first?.key
        itemNode.name = rawValue
        
        if let type = itemNode.textureType ?? textures.first?.key, let texture = textures[type] {
            itemNode.run(SKAction.setTexture(texture, resize: true))
        }
        
        itemNode.zPosition = zPosition
        return itemNode
    }
}
