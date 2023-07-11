//
//  BedroomScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BedroomScene: RoomBaseScene, PlayableSceneProtocol {
    
    typealias T = BedroomScene
    
    static func sharedScene(playerPosition: PositionIdentifier) -> BedroomScene? {
        return nil 
    }
    
    static func sharedScene(isTidy: Bool = true, playerPosition position: PositionIdentifier) -> BedroomScene? {
        let scene = BedroomScene(fileNamed: isTidy ? Constants.bedroomTidyScene : Constants.bedroomMessyScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        startFirstTimeEnteringEventIfNeeded()
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        if itemIdentifier == .photoAlbum, gameState?.getState(key: .friendsPhotosKept) != nil {
            node.isShowBubble = false
        } else {
            node.isShowBubble = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == ItemIdentifier.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else { return }
            
            switch(parentNode.name) {
            case ItemIdentifier.photoAlbum.rawValue:
                if gameState?.stateExisted(.friendsPhotosKept) == false {
                    sceneManager?.presentMGPhotoAlbumScene()
                }
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
extension BedroomScene {
    
    func startFirstTimeEnteringEventIfNeeded() {
        guard let gameState else { return }
        if !gameState.stateExisted(.friendsPhotosKept) {
            let photoAlbumNode = childNode(withName: ItemIdentifier.photoAlbum.rawValue)
            isUserInteractionEnabled = false
            if photoAlbumNode != nil {
                self.dialogBox?.startSequence(dialogs: [
                    DialogResources.bedroom_1_solo_seq1
                ], from: self, completion: {
                    self.isUserInteractionEnabled = true
                })
            } else {
                self.dialogBox?.startSequence(dialogs: [
                    DialogResources.bedroom_3_withPhoto_seq2
                ], from: self, completion: {
                    self.isUserInteractionEnabled = true
                })
            }
        }
    }
    
    func startSeeingAlbumEvent() {
        
    }
    
    func startPhotoAlbumGame() {
        
    }
    
    func changeRoomScenery() {
        
    }
    
    // State update according game event.
    func updateFriendsPhotosEventState(photosKept: Bool) {
        guard let gameState else { return }
        gameState.setState(key: .friendsPhotosKept, value: .boolValue(photosKept))
    }
    
}
