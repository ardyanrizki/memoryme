//
//  FirstMemoryScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class OfficeRoomScene: SKScene {
    var sceneManagerDelegate: SceneManagerDelegate?
    
    private var entities: [GKEntity] = []
    
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

extension OfficeRoomScene {
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

