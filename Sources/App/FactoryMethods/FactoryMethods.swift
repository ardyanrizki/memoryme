//
//  FactoryMethods.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

/// FactoryMethods provides convenient methods for creating characters and other game elements.
struct FactoryMethods {
    /// Creates a player character with specified textures at the given position.
    ///
    /// - Parameters:
    ///   - position: The position where the character will be created.
    /// - Returns: A player character instance.
    static func createPlayer(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.mainCharacter.getTexture()
        let idleTextures = TextureResources.mainCharacterAtlasIdle.textures
        let walkTextures = TextureResources.mainCharacterAtlasWalk.textures
        let layTextures = TextureResources.mainCharacterAtlasLay.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
            .lay: layTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.mainCharacterName)
    }
    
    /// Creates a colored player character with specified textures at the given position.
    ///
    /// - Parameters:
    ///   - position: The position where the character will be created.
    /// - Returns: A colored player character instance.
    static func createColoredPlayer(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.mainCharacter.getTexture()
        let idleTextures = TextureResources.mainCharacterAtlasRest.textures
        let sleepTextures = TextureResources.mainCharacterAtlasSleep.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .idle: idleTextures,
            .sleep: sleepTextures
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.mainCharacterName)
    }
    
    /// Creates a bartender character with specified textures at the given position.
    ///
    /// - Parameters:
    ///   - position: The position where the character will be created.
    /// - Returns: A bartender character instance.
    static func createBartender(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.bartenderCharacter.getTexture()
        let idleTextures = TextureResources.bartenderCharacterAtlasIdle.textures
        let walkTextures = TextureResources.bartenderCharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.bartenderName)
    }
    
    /// Creates a colored bartender character with specified textures at the given position.
    ///
    /// - Parameters:
    ///   - position: The position where the character will be created.
    /// - Returns: A colored bartender character instance.
    static func createColoredBartender(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.colorfulBartenderCharacter.getTexture()
        let idleTextures = TextureResources.colorfulBartenderCharacterAtlasIdle.textures
        let walkTextures = TextureResources.colorfulBartenderCharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.bartenderName)
    }
    
    /// Creates a colored mom character with specified textures at the given position.
    static func createColoredMom(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.momCharacter.getTexture()
        let idleTextures = TextureResources.momCharacterAtlasIdle.textures
        let walkTextures = TextureResources.momCharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.momName)
    }
    
    /// Creates a colored dad character with specified textures at the given position.
    static func createColoredDad(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.dadCharacter.getTexture()
        let idleTextures = TextureResources.dadCharacterAtlasIdle.textures
        let walkTextures = TextureResources.dadCharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.dadName)
    }
    
    /// Creates a colored friend 1 character with specified textures at the given position.
    static func createColoredFriend1(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.friend1Character.getTexture()
        let idleTextures = TextureResources.friend1CharacterAtlasIdle.textures
        let walkTextures = TextureResources.friend1CharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.friend1Name)
    }
    
    /// Creates a colored friend 2 character with specified textures at the given position.
    static func createColoredFriend2(at position: CGPoint) -> Character {
        let staticTexture = TextureResources.friend2Character.getTexture()
        let idleTextures = TextureResources.friend2CharacterAtlasIdle.textures
        let walkTextures = TextureResources.friend2CharacterAtlasWalk.textures
        
        let textures: [CharacterAnimationState: [SKTexture]] = [
            .static: [staticTexture],
            .walk: walkTextures,
            .idle: idleTextures,
        ]
        
        return Character(at: position, textures: textures, withIdentifier: Constants.friend2Name)
    }
    
    /// Creates an interactable item from a renderable item at the given position in the specified scene.
    static func createInteractableItem(from renderableItem: any RenderableItem, at position: CGPoint, in scene: SKScene) -> InteractableItem {
        InteractableItem(from: renderableItem, at: position, in: scene)
    }
    
    /// Creates a dialog box with the specified size, position, and corner radius.
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
        promptLabel.lineBreakMode = .byWordWrapping
        promptLabel.numberOfLines = 4
        promptLabel.fontSize = 40
        promptLabel.fontColor = .white
        promptLabel.position = CGPoint(x: -size.width / 2 + 20, y: size.height / 2 - 50)
        promptLabel.preferredMaxLayoutWidth = size.width - 80
        promptLabel.horizontalAlignmentMode = .left
        promptLabel.verticalAlignmentMode = .top
        dialogBox.addChild(promptLabel)
        dialogBox.promptLabel = promptLabel
        
        // Create the character name label.
        let nameLabel = SKLabelNode(fontNamed: Constants.fontName)
        nameLabel.text = .emptyString
        nameLabel.color = .blue
        nameLabel.horizontalAlignmentMode = .left
        nameLabel.fontSize = 48
        nameLabel.fontColor = .white
        nameLabel.position = CGPoint(x: -size.width / 2 + 20, y: size.height / 2 - 46)
        dialogBox.addChild(nameLabel)
        dialogBox.nameLabel = nameLabel
        
        return dialogBox
    }
    
    /// Creates an overlay look that can inject any child node into the scene.
    static func createOverlay(childNode: SKNode, in scene: SKScene) {
        let overlayWrapper = SKNode()
        overlayWrapper.name = Constants.overlayWrapper
        
        let overlayShape = SKShapeNode(rectOf: scene.size)
        overlayShape.fillColor = SKColor.black
        overlayShape.strokeColor = SKColor.black
        overlayShape.alpha = 0.5
        overlayShape.zPosition = Constants.defaultOverlayZPosition
        
        childNode.zPosition = Constants.defaultOverlayZPosition + 1
        childNode.alpha = 0
        
        overlayWrapper.addChild(overlayShape)
        overlayWrapper.addChild(childNode)
        scene.addChild(overlayWrapper)
        
        // Create an animation to scale up the fade alpha
        let scaleAction = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
        childNode.run(scaleAction)
    }
    
    /// Removes the overlay and its children from the scene.
    static func removeOverlay(in scene: SKScene) {
        guard let overlayWrapperNode = scene.childNode(withName: Constants.overlayWrapper) else {
            return
        }
        
        overlayWrapperNode.removeFromParent()
    }
}
