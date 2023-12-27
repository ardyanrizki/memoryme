//
//  PINInputFieldNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

/// A custom node representing a text field for PIN input.
class PINInputField: SKNode {
    
    // MARK: - Properties
    
    /// An array to store the reference nodes for position.
    var positionNodes = [SKNode]()
    
    /// An array to store the nodes that represent entered PIN digits.
    var digitNodes = [SKSpriteNode]()
    
    /// Node displaying an incorrect PIN message.
    var incorrectPINMessage: SKSpriteNode!
    
    /// The count of digits entered in the text field.
    var digitCount = 0
    
    /// The predefined passcode for unlocking.
    let unlockCombination = "0508"
    
    /// The combination of digits currently being entered.
    var enteredCombination = ""
    
    // MARK: - Initialization
    
    /// Set up the PIN input field by identifying child nodes.
    func setup() {
        for positionNode in self.children {
            if positionNode.name == TextureResources.incorrectPinText {
                incorrectPINMessage = self.childNode(withName: TextureResources.incorrectPinText) as? SKSpriteNode
            } else {
                positionNodes.append(positionNode)
            }
        }
    }
    
    // MARK: - User Interaction
    
    /// Fills a digit in the text field when a keypad button is clicked.
    ///
    /// - Parameters:
    ///   - number: The digit to be filled.
    ///   - completion: A closure to be executed upon completing PIN entry.
    func fillDigit(_ number: Int, completion: (() -> Void)) {
        if digitCount >= 4 { return }
        
        let digitSprite = SKSpriteNode(imageNamed: "num\(number)")
        digitSprite.name = "num\(number)"
        scene?.addChild(digitSprite)
        digitNodes.append(digitSprite)
        
        digitSprite.position = positionNodes[digitCount].parent!.convert(
            positionNodes[digitCount].position, to: scene!)
        
        // Workaround to set pin number's z position same as the screen
        digitSprite.zPosition = 2
        
        enteredCombination += "\(number)"
        
        digitCount += 1
        
        if digitCount == 4 {
            if enteredCombination == unlockCombination {
                digitNodes.forEach { $0.alpha = 0 }
                completion()
            } else {
                incorrectPINMessage.alpha = 1
            }
        }
    }
    
    /// Deletes the last entered digit from the text field.
    func deleteDigit() {
        if digitCount <= 0 { return }
        
        digitCount -= 1
        
        if incorrectPINMessage.alpha > 0 {
            incorrectPINMessage.alpha = 0
        }
        
        digitNodes[digitCount].removeFromParent()
        digitNodes.remove(at: digitCount)
        
        enteredCombination.removeLast()
    }
}
