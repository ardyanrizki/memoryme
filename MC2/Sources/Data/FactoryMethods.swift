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
    
    static func createInteractiveItem(name textureName: TextureName, at position: CGPoint) -> InteractiveItem {
        InteractiveItem(name: textureName, at: position)
    }
    
    static func createDialogBox(with size: CGSize, sceneFrame frame: CGRect, cornerRadius: CGFloat = 10) -> DialogBoxNode {
        // Create the box shape.
        let dialogBox = DialogBoxNode(rectOf: size, cornerRadius: cornerRadius)
        dialogBox.fillColor = UIColor.white.withAlphaComponent(0.7)
        dialogBox.strokeColor = .black
        dialogBox.lineWidth = 2.0
        dialogBox.position = CGPoint(x: frame.midX / 2, y: (frame.minY + (size.height / 2) + 75))
        dialogBox.zPosition = 1000

        // Create the prompt text label.
        let promptLabel = SKLabelNode(fontNamed: Constants.fontName)
        promptLabel.fontSize = 32
        promptLabel.fontColor = .black
        promptLabel.position = CGPoint(x: -size.width / 2 + 20, y: size.height / 2 - 70)
        promptLabel.horizontalAlignmentMode = .left
        promptLabel.text = ""
        dialogBox.addChild(promptLabel)
        dialogBox.promptLabel = promptLabel
        
        // Create the character name label.
        let nameLabel = SKLabelNode(fontNamed: Constants.fontName)
        nameLabel.fontSize = 40
        nameLabel.fontColor = .black
        nameLabel.position = CGPoint(x: -size.width / 2 + 50, y: size.height / 2 - 40)
        nameLabel.text = ""
        dialogBox.addChild(nameLabel)
        dialogBox.nameLabel = nameLabel

        // Assign the dialog box to the shared class property.
        SharedClass.dialogBox = dialogBox
        SharedClass.touchCount = 0
        
        return dialogBox
    }
}
