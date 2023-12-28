//
//  BedroomScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BedroomScene: ExplorationScene, PresentableSceneProtocol {
    
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            BedroomItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    typealias T = BedroomScene
    
    static func sharedScene(playerPosition: CharacterPosition) -> BedroomScene? {
        return nil
    }
    
    static func sharedScene(isTidy: Bool = true, playerPosition position: CharacterPosition) -> BedroomScene? {
        let scene = BedroomScene(fileNamed: isTidy ? Constants.bedroomTidyScene : Constants.bedroomMessyScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        Task {
            await startFirstTimeEnteringEventIfNeeded()
        }
    }
    
    override func playerDidContact(with item: any RenderableItem, node: ItemNode) {
        if item as? BedroomItem == .photoAlbum {
            node.isBubbleShown = stateManager?.getState(key: .friendsPhotosKept) != nil ? false : true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == SharingItem.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else { return }
            
            switch(parentNode.name) {
            case BedroomItem.photoAlbum.rawValue:
                if stateManager?.stateExisted(.friendsPhotosKept) == false {
                    sceneManager?.presentPhotoAlbumMiniGame()
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
    
    func startFirstTimeEnteringEventIfNeeded() async {
        guard let stateManager else { return }
        
        if !stateManager.stateExisted(.friendsPhotosKept) {
            isUserInteractionEnabled = false
            
            let photoAlbumNode = childNode(withName: BedroomItem.photoAlbum.rawValue)
            if photoAlbumNode != nil {
                await self.dialogBox?.start(dialog: DialogResources.bedroom1Solo, from: self)
            } else {
                await self.dialogBox?.start(dialog: DialogResources.bedroom5AfterCleaning, from: self)
            }
            
            self.isUserInteractionEnabled = true
        }
    }
    
    // State update according game event.
    func updateFriendsPhotosEventState(photosKept: Bool) {
        guard let stateManager else { return }
        stateManager.setState(key: .friendsPhotosKept, value: .boolValue(photosKept))
    }
    
}
