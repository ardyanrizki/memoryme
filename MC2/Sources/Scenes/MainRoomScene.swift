//
//  MainRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class MainRoomScene: SKScene {
    
    weak var sceneManagerDelegate: SceneManagerDelegate?
    
    private var entities: [GKEntity] = []
    
    private var playerNode: SKSpriteNode?
    
    private var doorToOffice: SKShapeNode?
    private var doorToBedroom: SKShapeNode?
    private var doorToBar: SKShapeNode?
    private var doorToHospital: SKShapeNode?
    
    override func didMove(to view: SKView) {
        createWorld()
        setupEntities()
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

extension MainRoomScene {
    private func createWorld() {}
    
    private func setupEntities() {
        var position = CGPoint(x: frame.midX, y: frame.midY)
        if let node = childNode(withName: "MorryStartingPoint") {
            position.x = node.position.x
            position.y = node.position.y
        }
        let player = createPlayer(position: position)
        player.node?.zPosition = 10
        entities.append(player)
        addChild(player.node ?? SKSpriteNode())
        playerNode = player.node
        
        doorToOffice = childNode(withName: "DoorToOfficeRoom") as? SKShapeNode
        doorToOffice?.zPosition = 99
        doorToOffice?.alpha = 0
    }
    
    private func createPlayer(position point: CGPoint) -> Player {
        let walkTextureAtlas = SKTextureAtlas(named: "MoryWalk")
        let walkTextures = walkTextureAtlas.textureNames.sorted().map {
            walkTextureAtlas.textureNamed($0)
        }
        let textures: [AnimationState: [SKTexture]] = [
            .walk: walkTextures
        ]
        return Player(position: point, textures: textures)
    }
}
