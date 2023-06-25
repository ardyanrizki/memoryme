//
//  DialogBoxNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class DialogBoxNode: SKShapeNode {
    
    var nameLabel: SKLabelNode?
    
    var promptLabel: SKLabelNode?
    
    var isShowing: Bool = false
    
    private var isTypingPrompt: Bool = false
    
    func show(dialog: Dialog, from scene: SKScene) {
        guard isShowing == false, let nameLabel, let promptLabel else { return }
        clearLabelText()
        removeAllActions()
        
        if self.scene == nil {
            scene.addChild(self)
        }
        
        nameLabel.text = dialog.name
        
        let characters = Array(dialog.prompt)
        var characterIndex = 0
        let addCharacterAction = SKAction.run {
            self.promptLabel?.text?.append(characters[characterIndex])
            characterIndex += 1
        }
        let delay = SKAction.wait(forDuration: 0.05)
        let runAddCharactersAction = SKAction.sequence([addCharacterAction, delay])
        let showAllPromptText = SKAction.repeat(runAddCharactersAction, count: characters.count)
        
        let endAction = SKAction.run {
            self.isTypingPrompt = false
        }
        
        isTypingPrompt = true
        let typingAnimation = SKAction.sequence([showAllPromptText, endAction])
        promptLabel.run(typingAnimation)
        isShowing = true
    }
    
    func skipTyping() {
        guard isTypingPrompt == true else { return }
        // TODO: Create method to skip typing animation.
    }
    
    func hide() {
        guard isTypingPrompt == false else { return }
        removeFromParent()
        isShowing = false
        clearLabelText()
    }
    
    private func clearLabelText() {
        nameLabel?.text = .emptyString
        promptLabel?.text = .emptyString
    }
}
