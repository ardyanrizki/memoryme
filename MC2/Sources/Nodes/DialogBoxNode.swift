//
//  DialogBoxNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class DialogBoxNode: SKShapeNode {
    lazy var nameLabel: SKLabelNode? = {
        nil
    }()
    
    lazy var promptLabel: SKLabelNode? = {
        nil
    }()
    
    func runDialog(_ dialog: Dialog) {
        nameLabel?.text = dialog.name
        
        let characters = Array(dialog.prompt)
        var characterIndex = 0
        let addCharacterAction = SKAction.run {
            self.promptLabel?.text?.append(characters[characterIndex])
            characterIndex += 1
        }
        let waitAction = SKAction.wait(forDuration: 0.05)
        let sequencedAction = SKAction.sequence([addCharacterAction, waitAction])
        let repeatAction = SKAction.repeat(sequencedAction, count: characters.count)
        
        promptLabel?.run(repeatAction)
    }
}
