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
    
    weak var sceneManagerDelegate: SceneManagerProtocol?
    
    private var entities: [GKEntity] = []
    
    private var playerNode: SKSpriteNode?
    
    private var dialogBox: DialogBoxNode?
    
    // MARK: Doors
    private var doorToOffice: SKShapeNode?
    private var doorToBedroom: SKShapeNode?
    private var doorToBar: SKShapeNode?
    private var doorToHospital: SKShapeNode?
    
    // MARK: Contactable Items
    private var vase: SKNode?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createWorld()
        setupEntities()
        setupInteractiveObject()
//        createDialogBox(Dialog(Constants.mainCharacterName, prompt: "Hello, this is a dialog box!"))
        dialogBox = FactoryMethods.createDialogBox(with: CGSize(width: frame.width - 200, height: 150), sceneFrame: frame)
        if let dialogBox {
            addChild(dialogBox)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkDoorCollision()
    }
    
    func checkDoorCollision() {
        if (playerNode?.intersects(doorToOffice ?? SKNode())) == true {
            sceneManagerDelegate?.presentOfficeRoomScene()
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
                dialogBox?.runDialog(DialogResources.strangeVase)
            }
        }
    }
    
    private func createWorld() {
        doorToOffice = childNode(withName: "DoorToOfficeRoom") as? SKShapeNode
        doorToOffice?.zPosition = 20
        doorToOffice?.alpha = 0
    }
    
    private func setupEntities() {
        var position = CGPoint(x: frame.midX, y: frame.midY)
        if let node = childNode(withName: "MorryStartingPoint") {
            position.x = node.position.x
            position.y = node.position.y
        }
        let player = FactoryMethods.createPlayer(at: position)
        player.node?.zPosition = 10
        entities.append(player)
        addChild(player.node ?? SKSpriteNode())
        playerNode = player.node
        
        vase = childNode(withName: "vase")
    }
    
    private func setupInteractiveObject(){
        let vase = InteractiveItem(name: TextureResources.vase, at: CGPoint(x: 148.014, y: 256.166))
        entities.append(vase)
        addChild(vase.node ?? SKSpriteNode())
        vase.node?.zPosition = 9
    }
}
