//
//  InputPinMiniGameScene.swift
//  Memoryme
//
//  Created by Clarabella Lius on 21/06/23.
//

import SpriteKit

/// The scene for entering a PIN code.
class InputPinMiniGameScene: GameScene {
    
    // MARK: - Properties
    
    /// An array of keypad nodes for digit input.
    var keypads: [KeypadNode]!
    
    /// The delete button node.
    var deleteButton: SKSpriteNode!
    
    /// The node representing the MacBook login screen.
    var macbookLoginScreen: SKSpriteNode!
    
    /// The custom PIN input field.
    var pinInputField: PINInputField!
    
    /// Flag to enable or disable touch events.
    var touchEventsEnabled: Bool = true
    
    // MARK: - Scene Lifecycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Find the laptopNode and assign it to the variable.
        guard let laptop = childNode(withName: TextureResources.macbookCloseUp) else {
            fatalError(.errorNodeNotFound)
        }
        
        macbookLoginScreen = childNode(withName: TextureResources.macbookLoginScreen) as? SKSpriteNode
        
        // Assign an empty array to keypads.
        keypads = [KeypadNode]()
        
        // Loop through all child nodes of the laptop.
        for node in laptop.children {
            // Check if the node is an instance of KeypadNode.
            if let keypad = node as? KeypadNode {
                keypad.setup()
                keypads.append(keypad)
            }
        }
        
        // Assign the delete button node.
        deleteButton = laptop.childNode(withName: "delete") as? SKSpriteNode
        
        // Assign the PIN input field node.
        pinInputField = laptop.childNode(withName: "PINInputField") as? PINInputField
        pinInputField.setup()
        
        // Set up the dialog box.
        setupDialogBox()
        Task {
            await dialogBox?.start(dialog: DialogResources.office3Computer, from: self)
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        // Detect touch location.
        let location = touches.first!.location(in: self)
        
        // Check if touch is on a keypad.
        for keypad in keypads where keypad.contains(location) {
            pinInputField.fillDigit(keypad.number, completion: handleCompletePIN)
            audioManager?.play(audioFile: .click, type: .soundEffect, volume: 1)
        }
        
        // Check if touch is on the delete button.
        if deleteButton.contains(location) {
            pinInputField.deleteDigit()
            audioManager?.play(audioFile: .click, type: .soundEffect, volume: 1)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        // Get the first touch.
        guard let touch = touches.first else {
            return
        }
        
        // Find the back label node.
        guard let backLabelNode = childNode(withName: TextureResources.backButton) as? SKSpriteNode else {
            return
        }
        
        // Get the touched location.
        let touchedLocation = touch.location(in: self)
        
        // Check if touch is on the back label node.
        if backLabelNode.contains(touchedLocation) {
            let fade = SKTransition.fade(withDuration: 0.5)
            sceneManager?.presentOffice(playerPosition: .officeComputerSpot, transition: fade)
        }
    }
    
    // MARK: - Event Handling
    
    func handleCompletePIN() {
        touchEventsEnabled = false
        macbookLoginScreen.alpha = 1
        
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let intervalAction = SKAction.wait(forDuration: 0.5)
        let presentNewScreen = SKAction.run {
            self.sceneManager?.presentMatchingNumbersMiniGame()
        }
        
        var actions = [SKAction]()
        actions.append(contentsOf: [
            fadeAction,
            intervalAction,
            presentNewScreen
        ])
        
        let sequencedActions = SKAction.sequence(actions)
        macbookLoginScreen.run(sequencedActions)
    }
}
