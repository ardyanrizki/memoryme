//
//  FactoryMethods.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

struct FactoryMethods {
    static let defaultOverlayZPosition: CGFloat = 99.0
    
    static func createPlayer(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.mainCharacter.getTexture()
        let idleTextures = TextureResources.mainCharacterAtlasIdle.getAllTexturesFromAtlas()
        let walkTextures = TextureResources.mainCharacterAtlasWalk.getAllTexturesFromAtlas()
        let layTextures = TextureResources.mainCharacterAtlasLay.getAllTexturesFromAtlas()
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
            .lay: layTextures
        ]
        
        return Character(at: position, textures: textures)
    }
    
    static func createBartender(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.bartenderCharacter.getTexture()
        let idleTextures = TextureResources.bartenderCharacterAtlasIdle.getAllTexturesFromAtlas()
        let walkTextures = TextureResources.bartenderCharacterAtlasWalk.getAllTexturesFromAtlas()
        
        var textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures)
    }
    
    static func createInteractableItem(with identifier: ItemIdentifier, at position: CGPoint, in scene: SKScene) -> InteractableItem {
        InteractableItem(withIdentifier: identifier, at: position, in: scene)
    }
    
    static func createDialogBox(with size: CGSize, sceneFrame frame: CGRect, cornerRadius: CGFloat = 10) -> DialogBoxNode {
        // Create the box shape.
        let dialogBox = DialogBoxNode(rectOf: size, cornerRadius: cornerRadius)
        dialogBox.fillColor = UIColor.black.withAlphaComponent(0.9)
        dialogBox.strokeColor = .white
        dialogBox.lineWidth = 2.0
        dialogBox.position = CGPoint(x: frame.midX / 2, y: (frame.minY + (size.height / 2) + 75))
        dialogBox.zPosition = 100

        // Create the prompt text label.
        let promptLabel = SKLabelNode(fontNamed: Constants.fontName)
        promptLabel.text = .emptyString
        promptLabel.fontSize = 40
        promptLabel.fontColor = .white
        promptLabel.position = CGPoint(x: -size.width / 2 + 20, y: size.height / 2 - 70)
        promptLabel.horizontalAlignmentMode = .left
        dialogBox.addChild(promptLabel)
        dialogBox.promptLabel = promptLabel
        
        // Create the character name label.
        let nameLabel = SKLabelNode(fontNamed: Constants.fontName)
        nameLabel.text = .emptyString
        nameLabel.fontSize = 48
        nameLabel.fontColor = .white
        nameLabel.position = CGPoint(x: -size.width / 2 + 50, y: size.height / 2 - 40)
        dialogBox.addChild(nameLabel)
        dialogBox.nameLabel = nameLabel
        
        return dialogBox
    }
    
    /** Create an overlay look that can inject any child node*/
    static func createOverlay(childNode: SKNode, in scene: SKScene) {
        let overlayWrapper = SKNode()
        overlayWrapper.name = Constants.overlayWrapper
        
        let overlayShape = SKShapeNode(rectOf: scene.size)
        overlayShape.fillColor = SKColor.black
        overlayShape.strokeColor = SKColor.black
        overlayShape.alpha = 0.5
        overlayShape.zPosition = defaultOverlayZPosition
        
        childNode.zPosition = defaultOverlayZPosition + 1
        childNode.alpha = 0
        
        overlayWrapper.addChild(overlayShape)
        overlayWrapper.addChild(childNode)
        scene.addChild(overlayWrapper)
        
        // Create an animation to scale up the fade alpha
        let scaleAction = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        childNode.run(scaleAction)
    }
    
    /** Remove overlay and its children */
    static func removeOverlay(in scene: SKScene) {
        guard let overlayWrapperNode = scene.childNode(withName: Constants.overlayWrapper) else {
            return
        }
        
        overlayWrapperNode.removeFromParent()
    }
}
