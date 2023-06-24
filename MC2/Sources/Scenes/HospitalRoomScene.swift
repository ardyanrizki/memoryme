//
//  HospitalRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 21/06/23.
//

import SpriteKit
import GameplayKit

class HospitalRoomScene: SKScene {
    var sceneManagerDelegate: SceneManagerProtocol?
    
    private var entities: [GKEntity] = []
    
    override func didMove(to view: SKView) {
        createWorld()
        setupEntities()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
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

extension HospitalRoomScene {
    private func createWorld() {
        let roomBackground = SKSpriteNode(imageNamed: "MainRoom")
        roomBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(roomBackground)
    }
    
    private func setupEntities() {
        let player = createPlayer()
        player.node?.zPosition = 10
        entities.append(player)
        addChild(player.node ?? SKSpriteNode())
    }
    
    private func createPlayer() -> Player {
        let walkTextureAtlas = SKTextureAtlas(named: "MoryWalk")
        let walkTextures = walkTextureAtlas.textureNames.sorted().map {
            walkTextureAtlas.textureNamed($0)
        }
        let stateTextures: [AnimationState: [SKTexture]] = [
            .walk: walkTextures
        ]
        let position = CGPoint(x: frame.midX, y: frame.midY)
        return Player(at: position, textures: stateTextures)
    }
}

