//
//  DialogBoxNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

/// A custom `SKShapeNode` representing a dialog box in a scene.
class DialogBoxNode: SKShapeNode {
    
    // MARK: - Properties
    
    /// The label displaying the name of the speaker in the dialog.
    var nameLabel: SKLabelNode?
    
    /// The label displaying the dialog prompt text.
    var promptLabel: SKLabelNode?
    
    /// A flag indicating whether the dialog box is currently displayed.
    var isShowing: Bool = false
    
    /// The text of the active prompt being typed.
    var activePromptText: String?
    
    /// A flag indicating whether the prompt text is currently being typed.
    private var isTypingPrompt: Bool = false
    
    // MARK: - Dialog Methods
    
    /// Initiates a dialog sequence for a single dialog item.
    ///
    /// - Parameters:
    ///   - dialog: The dialog item to be displayed.
    ///   - scene: The `SKScene` to which the dialog box should be added.
    ///   - interval: The duration to wait after displaying the dialog.
    func start(dialog: Dialog, from scene: SKScene, withInterval interval: TimeInterval = 1.0) async {
        guard isShowing == false else { return }
        
        await withCheckedContinuation { continuation in
            clearLabelText()
            removeAllActions()
            
            if self.scene == nil {
                scene.addChild(self)
            }
            
            let startDialog = SKAction.group([
                changeNameLabelAction(for: dialog),
                promptTypingAction(for: dialog)
            ])
            
            let intervalAction = SKAction.wait(forDuration: interval)
            
            let completionAction = SKAction.run {
                self.removeFromParent()
                continuation.resume()
            }
            
            let sequenceAction = SKAction.sequence([
                startDialog,
                intervalAction,
                completionAction
            ])
            
            run(sequenceAction)
        }
    }
    
    /// Initiates a dialog sequence for multiple dialog items.
    ///
    /// - Parameters:
    ///   - dialogs: An array of dialog items to be displayed sequentially.
    ///   - scene: The `SKScene` to which the dialog box should be added.
    ///   - interval: The duration to wait after displaying each dialog.
    func start(dialogs: [Dialog], from scene: SKScene, withInterval interval: TimeInterval = 1.0) async {
        guard isShowing == false else { return }
        
        await withCheckedContinuation { continuation in
            clearLabelText()
            removeAllActions()
            
            if self.scene == nil {
                scene.addChild(self)
            }
            
            let intervalAction = SKAction.wait(forDuration: interval)
            
            var actions = [SKAction]()
            
            for (index, dialog) in dialogs.enumerated() {
                let startDialog = SKAction.group([
                    changeNameLabelAction(for: dialog),
                    promptTypingAction(for: dialog)
                ])
                actions.append(contentsOf: [
                    startDialog,
                    intervalAction
                ])
                
                if index < dialogs.count - 1 {
                    actions.append(contentsOf: [
                        clearNameLabelTextAction(),
                        clearPromptLabelTextAction()
                    ])
                }
            }
            
            let completionAction = SKAction.run {
                continuation.resume()
                self.removeFromParent()
            }
            
            actions.append(completionAction)
            
            let sequenceAction = SKAction.sequence(actions)
            
            run(sequenceAction)
        }
    }
    
    // MARK: - Action Methods
    
    /// Creates an action to change the name label for a given dialog.
    ///
    /// - Parameter dialog: The dialog item containing the name to be displayed.
    /// - Returns: An `SKAction` to update the name label.
    func changeNameLabelAction(for dialog: Dialog) -> SKAction {
        guard let nameLabel else { fatalError(.errorNodeNotFound) }
        return SKAction.run {
            nameLabel.text = dialog.name ?? .emptyString
        }
    }
    
    /// Creates an action to animate typing the prompt text for a given dialog.
    ///
    /// - Parameter dialog: The dialog item containing the prompt text to be displayed.
    /// - Returns: An `SKAction` to animate typing the prompt text.
    func promptTypingAction(for dialog: Dialog) -> SKAction {
        guard let promptLabel else { fatalError(.errorNodeNotFound) }
        
        let startTyping = SKAction.run {
            self.isTypingPrompt = true
            self.activePromptText = dialog.prompt
        }
        
        let characters = Array(dialog.prompt)
        var characterIndex = 0
        let typingEachCharacter = SKAction.run {
            promptLabel.text?.append(characters[characterIndex])
            characterIndex += 1
        }
        let typingDelay = SKAction.wait(forDuration: 0.05)
        let typingPerCharacter = SKAction.sequence([typingEachCharacter, typingDelay])
        let repeatedTyping = SKAction.repeat(typingPerCharacter, count: characters.count)
        
        let endTyping = SKAction.run {
            self.isTypingPrompt = false
            self.activePromptText = nil
        }
        
        return SKAction.sequence([startTyping, repeatedTyping, endTyping])
    }
    
    /// Skips the typing animation and displays the full prompt text.
    func skipTyping() {
        guard isTypingPrompt == true, let activePromptText else { return }
        removeAllActions()
        promptLabel?.text = activePromptText
        isTypingPrompt = false
    }
    
    // MARK: - Display and Interaction Methods
    
    /// Hides the dialog box, ending any ongoing animations.
    func hide() {
        guard isTypingPrompt == false else { return }
        removeFromParent()
        isShowing = false
        clearLabelText()
    }
    
    /// Handles touch events on the dialog box.
    ///
    /// - Parameter touchLocation: The location of the touch event.
    func handleTouch(on touchLocation: CGPoint) {
        if contains(touchLocation) == true {
            // Skip `dialogBox` typing animation if running.
            skipTyping()
        } else if isTypingPrompt == false {
            hide()
        }
    }
    
    // MARK: - Private Helper Methods
    
    /// Clears the text content of the name and prompt labels.
    private func clearLabelText() {
        nameLabel?.text = .emptyString
        promptLabel?.text = .emptyString
    }
    
    /// Creates an action to clear the prompt label text.
    ///
    /// - Returns: An `SKAction` to clear the prompt label text.
    private func clearPromptLabelTextAction() -> SKAction {
        SKAction.run {
            self.promptLabel?.text = .emptyString
        }
    }
    
    /// Creates an action to clear the name label text.
    ///
    /// - Returns: An `SKAction` to clear the name label text.
    private func clearNameLabelTextAction() -> SKAction {
        SKAction.run {
            self.nameLabel?.text = .emptyString
        }
    }
}
