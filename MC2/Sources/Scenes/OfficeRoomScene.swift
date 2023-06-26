//
//  FirstMemoryScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class OfficeRoomScene: SKScene, SKPhysicsContactDelegate {
    var sceneManagerDelegate: SceneManagerDelegate?
    
    private var entities: [GKEntity] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createWorld()
        setupEntities()
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkDoorCollision()
    }
    
    func checkDoorCollision() {
        guard let characterNode = childNode(withName: CharacterType.mainCharacter.rawValue) as? SKSpriteNode else {
            return
        }
        
        guard let doorMainRoom = childNode(withName: "DoorToMainRoom") as? SKShapeNode else {
            return
        }
        
        
        if characterNode.intersects(doorMainRoom) {
            sceneManagerDelegate?.presentMainRoomScene()
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
   
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        if ((SharedClass.dialogBox?.contains(touchLocation)) != nil) {
            // Close the dialog box
            SharedClass.dialogBox.removeFromParent()
        } else {
            for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        if !SharedClass.showDialog {
            // Perform the object movement based on the touch
            for case let player as Player in entities {
                player.walk(to: touchLocation)
            }
        } else {
            SharedClass.showDialog = false
            return
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}

extension OfficeRoomScene {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == 1 || contact.bodyB.categoryBitMask == 1 {
            print(contact.bodyA, contact.bodyB)
            contact.bodyB.node?.removeAllActions()
            if (contact.bodyA.node?.name == "Photoframe") && !SharedClass.showDialog {
                createDialogBox(dialogString: "This is photo with my family, the date it was taken 24 June", characterName: "Mory")
            }
            if (contact.bodyA.node?.name == "Macbook") && !SharedClass.showDialog {
                createDialogBox(dialogString: "My wornout macbook that have been with me when i enter the work. My wornout macbook that have been with me when i enter the work. My wornout macbook that have been with me when i enter the work. My wornout macbook that have been with me when i enter the work. My wornout macbook that have been with me when i enter the work", characterName: "Mory")
            }
        }
    }
    
    private func createDialogBox(dialogString: String, characterName: String) {
        // Create the dialog box node
        let dialogBoxWidth: CGFloat = frame.width - 200
        let dialogBoxHeight: CGFloat = 150
        // Create the dialog box node
        let dialogBox = SKShapeNode(rectOf: CGSize(width: dialogBoxWidth, height: dialogBoxHeight), cornerRadius: 10)
        dialogBox.fillColor = UIColor.black.withAlphaComponent(0.7) // Set opacity to 70%
        dialogBox.strokeColor = .white
        dialogBox.lineWidth = 2.0
        // Calculate the position for aligning to the bottom center
        dialogBox.position = CGPoint(x: frame.midX / 2, y: (frame.minY + (dialogBoxHeight/2) + 75))
        dialogBox.zPosition = 1000

        // Create the text label
        let textLabel = SKLabelNode(fontNamed: "Scribble-Regular")
        textLabel.fontSize = 32
        textLabel.fontColor = .white
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.horizontalAlignmentMode = .center
        textLabel.verticalAlignmentMode = .center
        textLabel.numberOfLines = 0 // Allow multiple lines
        textLabel.preferredMaxLayoutWidth = dialogBoxWidth * 0.8
        textLabel.position = CGPoint(x: -dialogBoxWidth / 2 + 20, y: dialogBoxHeight / 2 - 70) // Align text to the left
        
        // Set the initial text of the dialog text label
        textLabel.text = ""
        
        // Create the character name label
        let characterNameLabel = SKLabelNode(fontNamed: "Scribble-Regular")
        characterNameLabel.fontSize = 40
        characterNameLabel.fontColor = .white
        characterNameLabel.position = CGPoint(x: -dialogBoxWidth / 2 + 50, y: dialogBoxHeight / 2 - 40)
        characterNameLabel.text = characterName

        
        // Assign the dialog box to the shared class property
        SharedClass.dialogBox = dialogBox
        SharedClass.showDialog = true
        
        // Set the text alignment to left
        textLabel.horizontalAlignmentMode = .left

        // Add the character name label to the dialog box
        dialogBox.addChild(characterNameLabel)
        
        // Add the label to the dialog box node
        dialogBox.addChild(textLabel)

        // Add the dialog box node to the scene
        addChild(dialogBox)
        
        // Start the dialog box animation
        animateDialogText(dialogString: dialogString, dialogText: textLabel)

    }
    
    private func animateDialogText(dialogString: String, dialogText: SKLabelNode) {
        let characters = Array(dialogString)
        var characterIndex = 0
        
        let addCharacterAction = SKAction.run {
            dialogText.text?.append(characters[characterIndex])
            characterIndex += 1
        }
        
        let waitAction = SKAction.wait(forDuration: 0.05)
        let sequenceAction = SKAction.sequence([addCharacterAction, waitAction])
        let repeatAction = SKAction.repeat(sequenceAction, count: characters.count)
        
        dialogText.run(repeatAction)
    }
    
    private func createWorld() {}
    
    private func setupEntities(){
        var xPosition = frame.midX
        var yPosition = frame.midY
        
        // To change position of Main character based on scene
        if let node = childNode(withName: "MorryStartingPoint") {
            xPosition = node.position.x
            yPosition = node.position.y
        }
        
        let mainCharacter = Player(position: CGPoint(x: xPosition, y: yPosition))
        entities.append(mainCharacter)
        addChild(mainCharacter.node ?? SKSpriteNode())
        mainCharacter.node?.zPosition = 10
    }
}

