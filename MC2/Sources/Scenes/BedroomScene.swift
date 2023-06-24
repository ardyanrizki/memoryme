//
//  SecondMemoryScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BedroomScene: SKScene {
    var sceneManagerDelegate: SceneManagerDelegate?
    
    private var entities: [GKEntity] = []
    
    /**
     hard-coded value to simulate tidy or messy scene on Bedroom
     TODO: replace this value with game state
    */
    let STATE_TIDYNESS_ROOM = false
    
    override func sceneDidLoad() {
        createWorld()
        setupEntities()
    }
    
    override func didMove(to view: SKView) {
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
        
        guard let doorMainRoom = childNode(withName: "doorToMainRoom") as? SKShapeNode else {
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
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        
        for case let player as Player in entities {
            player.walk(to: touchLocation)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}

extension BedroomScene {
    private func createWorld() {
        guard let messyParentNode = childNode(withName: "messySectionNode") as SKNode? else {
            return
        }
        
        guard let tidyParentNode = childNode(withName: "tidySectionNode") as SKNode? else {
            return
        }
        
        if STATE_TIDYNESS_ROOM {
            tidyParentNode.alpha = 1
            messyParentNode.alpha = 0
            
            let tidyBoundingBox = tidyParentNode.calculateAccumulatedFrame()
            
            tidyParentNode.physicsBody = SKPhysicsBody(rectangleOf: tidyBoundingBox.size)
            tidyParentNode.physicsBody?.isDynamic = false
        } else {
            tidyParentNode.alpha = 0
            messyParentNode.alpha = 1
            
            messyParentNode.children.forEach { childNode in
                if let spriteNode = childNode as? SKSpriteNode {
                    let decorationEntity = DecorativeItem(
                        node: spriteNode,
                        name: spriteNode.name!
                    )
                    
                    entities.append(decorationEntity)
                }
            }
            
            let photoAlbum = IntercativeItem(
                position: CGPoint(x: frame.midX, y: frame.midY),
                name: "photo-allbum",
                type: .photoAlbum
            )
            entities.append(photoAlbum)
            addChild(photoAlbum.node!)
            photoAlbum.node?.zPosition = 10
        }
    }
    
    private func setupEntities(){
        var xPosition = frame.midX
        var yPosition = frame.midY
        
        // To change origin position of Main character when entering the scene
        if let node = childNode(withName: "entrancePoint") {
            xPosition = node.position.x
            yPosition = node.position.y
            
            // hide the node so the the scene does not display two character
            node.alpha = 0
        }
        
        let mainCharacter = Player(position: CGPoint(x: xPosition, y: yPosition))
        entities.append(mainCharacter)
        addChild(mainCharacter.node ?? SKSpriteNode())
        mainCharacter.node?.zPosition = 10
    }
}
