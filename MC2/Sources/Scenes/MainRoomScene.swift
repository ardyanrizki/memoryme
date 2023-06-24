//
//  MainRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class SharedClass {
    static var dialogBox: SKShapeNode!
    static var touchCount: Int = 0
}

class MainRoomScene: SKScene, SKPhysicsContactDelegate {
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    private var entities: [GKEntity] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
//        createWorld()
        setupEntities()
        setupInteractiveObject()
        createDialogBox(dialogString: "Hello, this is a dialog box!", characterName: "Mory")
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkDoorCollision()
    }
    
    func checkDoorCollision() {
        guard let characterNode = childNode(withName: CharacterType.mainCharacter.rawValue) as? SKSpriteNode else {
            return
        }
        
        guard let doorOffice = childNode(withName: "DoorToOfficeRoom") as? SKShapeNode else {
            return
        }
        
        guard let doorBedroom = childNode(withName: "DoorToRoom") as? SKShapeNode else {
            return
        }
        
        if characterNode.intersects(doorOffice) {
            sceneManagerDelegate?.presentOfficeRoomScene()
        }
        
        if characterNode.intersects(doorBedroom) {
            sceneManagerDelegate?.presentBedroomScene()
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
        if !SharedClass.dialogBox.contains(touchLocation) {
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
        SharedClass.touchCount += 1
        print(SharedClass.touchCount)
        // Perform object movement only when the dialog box is close and one touch after that
        if SharedClass.touchCount >= 2 {
            // Perform the object movement based on the touch
            for case let player as Player in entities {
                player.walk(to: touchLocation)
            }
        } else {
            return
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}

extension MainRoomScene {
    func didBegin(_ contact: SKPhysicsContact) {
        print(contact.bodyA, contact.bodyB)
        if contact.bodyA.categoryBitMask == 1 || contact.bodyB.categoryBitMask == 1 {
            contact.bodyA.node?.removeAllActions()
            if (contact.bodyB.node?.name == "vase") {
                createDialogBox(dialogString: "This is Vase... Wait there is something strange about the flower", characterName: "Mory")
            }
        }
    }
    
    private func createWorld() {
        let roomBackground = SKSpriteNode(imageNamed: "MainRoom")
        roomBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(roomBackground)
    }
    
    private func setupEntities(){
        let mainCharacter = Player(position: CGPoint(x: frame.midX, y: frame.midY))
        entities.append(mainCharacter)
        addChild(mainCharacter.node ?? SKSpriteNode())
        mainCharacter.node?.zPosition = 10
    }
    
    private func setupInteractiveObject(){
        let vase = IntercativeItem(position: CGPoint(x: 148.014, y: 256.166), name: "vase")
        entities.append(vase)
        addChild(vase.node ?? SKSpriteNode())
        vase.node?.zPosition = 9
    }
    
    private func createDialogBox(dialogString: String, characterName: String) {
        // Create the dialog box node
        let dialogBoxWidth: CGFloat = frame.width - 200
        let dialogBoxHeight: CGFloat = 150
        // Create the dialog box node
        let dialogBox = SKShapeNode(rectOf: CGSize(width: dialogBoxWidth, height: dialogBoxHeight), cornerRadius: 10)
        dialogBox.fillColor = UIColor.white.withAlphaComponent(0.7) // Set opacity to 70%
        dialogBox.strokeColor = .black
        dialogBox.lineWidth = 2.0
        // Calculate the position for aligning to the bottom center
        dialogBox.position = CGPoint(x: frame.midX / 2, y: (frame.minY + (dialogBoxHeight/2) + 75))
        dialogBox.zPosition = 1000

        // Create the text label
        let textLabel = SKLabelNode(fontNamed: "Scribble-Regular")
        textLabel.fontSize = 32
        textLabel.fontColor = .black
        textLabel.position = CGPoint(x: -dialogBoxWidth / 2 + 20, y: dialogBoxHeight / 2 - 70) // Align text to the left
        
        // Set the initial text of the dialog text label
        textLabel.text = ""
        
        // Create the character name label
        let characterNameLabel = SKLabelNode(fontNamed: "Scribble-Regular")
        characterNameLabel.fontSize = 40
        characterNameLabel.fontColor = .black
        characterNameLabel.position = CGPoint(x: -dialogBoxWidth / 2 + 50, y: dialogBoxHeight / 2 - 40)
        characterNameLabel.text = characterName

        
        // Assign the dialog box to the shared class property
        SharedClass.dialogBox = dialogBox
        SharedClass.touchCount = 0
        
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
}
