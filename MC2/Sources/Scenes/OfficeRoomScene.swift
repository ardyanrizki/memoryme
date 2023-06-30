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
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == ItemIdentifier.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else {
                return
            }
            
            switch(parentNode.name) {
            case ItemIdentifier.macbook.rawValue:
                sceneManager?.presentMGPasswordScene()
                break
                
            case ItemIdentifier.photoframe.rawValue:
                showPhotoFrame()
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
    
    func showPhotoFrame() {
        let texture = SKTexture(imageNamed: TextureResources.familyPhotoFrame)
        let familyPhotoFrame = SKSpriteNode(texture: texture)
        familyPhotoFrame.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        familyPhotoFrame.size.width = 528
        familyPhotoFrame.size.height = 640
        
        FactoryMethods.createOverlay(childNode: familyPhotoFrame, in: self)
        
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.office_1_photoframe_seq1,
            DialogResources.office_2_photoframe_seq2,
        ], from: self, completion: {
            FactoryMethods.removeOverlay(in: self)
        })
    }
}
