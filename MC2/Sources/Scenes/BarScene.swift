//
//  BarScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BarScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = BarScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> BarScene? {
        let scene = BarScene(fileNamed: Constants.barScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        firstEnterBar()
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        node.isShowBubble = true
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == ItemIdentifier.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else {
                return
            }
            
            switch(parentNode.name) {
            case ItemIdentifier.radioBar.rawValue:
                sceneManager?.presentMGRadioScene()
                break
                
            default:
                
                break
            }
        } else {
            FactoryMethods.removeOverlay(in: self)
        }
    }
}

// MARK: Scene's Events
extension BarScene {
    
    func firstEnterBar() {
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.bar_1_solo_seq1
        ], from: self)
    }
    
    func startPlayRadioEvent() {
        
    }
    
    func startRadioGame() {
        
    }
    
    func startTheStrangerSnapshots() {
        
    }
    
    func startTheBartenderEvent() {
        
    }
    
    // State update according game event.
    func updateSaveStrangerEventState(strangerSaved: Bool) {
        guard let gameState else { return }
        gameState.setState(key: .strangerSaved, value: .boolValue(strangerSaved))
    }
    
}
