//
//  FactoryMethods.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

struct FactoryMethods {
    static func createPlayer(at position: CGPoint) -> Player {
        Player(at: position)
    }
    
    static func createInteractiveItem(with identifier: ItemIdentifier, at position: CGPoint, withScene scene: SKScene) -> InteractiveItem {
        InteractiveItem(with: identifier, at: position, withScene: scene)
    }
    
    static func createDialogBox(with size: CGSize, sceneFrame frame: CGRect, cornerRadius: CGFloat = 10) -> DialogBoxNode {
        // Create the box shape.
        let dialogBox = DialogBoxNode(rectOf: size, cornerRadius: cornerRadius)
        dialogBox.fillColor = UIColor.white.withAlphaComponent(0.95)
        dialogBox.strokeColor = .black
        dialogBox.lineWidth = 2.0
        dialogBox.position = CGPoint(x: frame.midX / 2, y: (frame.minY + (size.height / 2) + 75))
        dialogBox.zPosition = 100

        // Create the prompt text label.
        let promptLabel = SKLabelNode(fontNamed: Constants.fontName)
        promptLabel.text = .emptyString
        promptLabel.fontSize = 32
        promptLabel.fontColor = .black
        promptLabel.position = CGPoint(x: -size.width / 2 + 20, y: size.height / 2 - 70)
        promptLabel.horizontalAlignmentMode = .left
        dialogBox.addChild(promptLabel)
        dialogBox.promptLabel = promptLabel
        
        // Create the character name label.
        let nameLabel = SKLabelNode(fontNamed: Constants.fontName)
        nameLabel.text = .emptyString
        nameLabel.fontSize = 40
        nameLabel.fontColor = .black
        nameLabel.position = CGPoint(x: -size.width / 2 + 50, y: size.height / 2 - 40)
        dialogBox.addChild(nameLabel)
        dialogBox.nameLabel = nameLabel
        
        return dialogBox
    }
}
