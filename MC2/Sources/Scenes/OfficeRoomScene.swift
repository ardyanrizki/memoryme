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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        startFirstTimeEnteringEventIfNeeded()
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        if itemIdentifier == .macbook, gameState?.getState(key: .momsCallAccepted) != nil {
            node.isShowBubble = false
        } else {
            node.isShowBubble = true
        }
    }
    
    override func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == ItemIdentifier.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else { return }
            
            switch(parentNode.name) {
            case ItemIdentifier.macbook.rawValue:
                startInputPinGame()
            case ItemIdentifier.photoframe.rawValue:
                showPhotoFrame()
            default:
                break
            }
        } else {
            FactoryMethods.removeOverlay(in: self)
        }
    }
    
    func showPhotoFrame() {
        let texture = SKTexture(imageNamed: TextureResources.familyPhotoFrame)
        let familyPhotoFrame = SKSpriteNode(texture: texture)
        familyPhotoFrame.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        familyPhotoFrame.size.width = 528
        familyPhotoFrame.size.height = 640
        
        isUserInteractionEnabled = false
        
        FactoryMethods.createOverlay(childNode: familyPhotoFrame, in: self)
        
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.office_1_photoframe_seq1,
            DialogResources.office_2_photoframe_seq2,
        ], from: self, completion: {
            FactoryMethods.removeOverlay(in: self)
            self.isUserInteractionEnabled = true
        })
    }
}

// MARK: Scene's Events
extension OfficeRoomScene {
    
    func startFirstTimeEnteringEventIfNeeded() {
        guard let gameState else { return }
        if !gameState.stateExisted(.momsCallAccepted) {
            isUserInteractionEnabled = false
            self.dialogBox?.startSequence(dialogs: [
                DialogResources.office_1_solo_seq1
            ], from: self, completion: {
                self.isUserInteractionEnabled = true
            })
        }
    }
    
    func startMomsCallEvent() {
        
    }
    
    func startInputPinGame() {
        guard gameState?.getState(key: .momsCallAccepted) == nil else { return }
        sceneManager?.presentMGInputPinScene()
    }
    
    // State updates according game event.
    func updateMomCallEventState(callAccepted: Bool) {
        guard let gameState else { return }
        gameState.setState(key: .momsCallAccepted, value: .boolValue(callAccepted))
    }
}
