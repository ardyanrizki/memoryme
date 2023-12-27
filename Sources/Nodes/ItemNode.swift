//
//  ItemNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

class ItemNode: SKSpriteNode {
    
    // MARK: - Properties
    
    var renderableItem: (any RenderableItem)?
    var textures: [ItemTextureType: SKTexture]?
    var textureType: ItemTextureType? {
        didSet {
            updateTexture()
        }
    }
    
    var infoBubble: InteractableItem?
    
    var isBubbleShown: Bool = false {
        didSet {
            animateBubble(show: isBubbleShown)
        }
    }
    
    // MARK: - Methods
    
    func createInteractableItem(in scene: SKScene, withTextureType textureType: ItemTextureType?) -> InteractableItem {
        guard let item = renderableItem else { fatalError(.errorRenderableItemNotSet) }
        let itemTextures = item.textures
        return InteractableItem(withNode: self, textures: itemTextures)
    }
    
    // MARK: - Private Methods
    
    private func updateTexture() {
        guard let textureType = textureType, let newTexture = textures?[textureType] else { return }
        run(SKAction.setTexture(newTexture, resize: true))
    }
    
    private func animateBubble(show: Bool) {
        guard let infoBubble, let animationComponent = infoBubble.component(ofType: AnimationComponent.self) else {
            return
        }
        
        infoBubble.node?.zPosition = 20
        
        if show {
            infoBubble.showPhysicsBody()
            infoBubble.node?.alpha = 1
            let atlasName = TextureResources.bubbleAtlasStatic
            animationComponent.animate(withTextures: atlasName.textures, withKey: "animateBubble")
        } else {
            infoBubble.node?.alpha = 0
            infoBubble.hidePhysicsBody()
            animationComponent.removeAnimation()
        }
    }
}
