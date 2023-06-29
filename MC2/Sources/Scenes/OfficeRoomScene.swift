//
//  FirstMemoryScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class OfficeRoomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = OfficeRoomScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> OfficeRoomScene? {
        let scene = OfficeRoomScene(fileNamed: Constants.officeRoomScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        node.isShowBubble = true
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
}

// MARK: Scene's Events
extension OfficeRoomScene {
    
    func startMomsCallEvent() {
        
    }
    
    func startAngryManagerSnapshots() {
        
    }
    
    func startInputPinGame() {
        
    }
    
    func startMatchNumberGame() {
        
    }
    
    // State updates according game event.
    func updateMomCallEventState(callAccepted: Bool) {
        guard let gameState else { return }
        gameState.setState(key: .momsCallAccepted, value: .boolValue(callAccepted))
    }
}
