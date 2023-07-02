//
//  BedroomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BedroomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = BedroomScene
    
    static func sharedScene(playerPosition position: PositionIdentifier) -> BedroomScene? {
        let scene = BedroomScene(fileNamed: Constants.bedroomScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    static func sharedSceneTidy(playerPosition position: PositionIdentifier) -> BedroomScene? {
        let scene = BedroomScene(fileNamed: Constants.bedroomTidyScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        firstEnterBedroom()
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
            case ItemIdentifier.photoAlbum.rawValue:
                sceneManager?.presentMGPhotoAlbumScene()
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
    
    func firstEnterBedroom() {
        let photoAlbumNode = childNode(withName: "photoAlbum")
        if photoAlbumNode != nil {
            self.dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_1_solo_seq1
            ], from: self)
        } else {
            self.dialogBox?.startSequence(dialogs: [
                DialogResources.bedroom_3_withPhoto_seq2
            ], from: self)
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
