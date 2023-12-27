//
//  FirstMemoryScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class OfficeScene: RoomScene, PresentableSceneProtocol {
    
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            OfficeItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    typealias T = OfficeScene
    
    static func sharedScene(playerPosition position: CharacterPosition) -> OfficeScene? {
        let scene = OfficeScene(fileNamed: Constants.officeRoomScene)
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
        if item as? OfficeItem == .macBook {
            node.isBubbleShown = gameStateManager?.getState(key: .momsCallAccepted) != nil ? false : true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        Task {
            if touchedNode!.name == SharingItem.bubble.rawValue {
                // Indicate touched node does not have any parent
                guard let parentNode = touchedNode?.parent else { return }
                
                switch(parentNode.name) {
                case OfficeItem.macBook.rawValue:
                    startInputPinGame()
                case OfficeItem.photoFrame.rawValue:
                    await showPhotoFrame()
                default:
                    break
                }
            } else {
                FactoryMethods.removeOverlay(in: self)
            }
        }
    }
    
    func showPhotoFrame() async {
        let texture = SKTexture(imageNamed: TextureResources.familyPhotoFrame)
        let familyPhotoFrame = SKSpriteNode(texture: texture)
        familyPhotoFrame.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        familyPhotoFrame.size.width = 528
        familyPhotoFrame.size.height = 640
        
        isUserInteractionEnabled = false
        
        FactoryMethods.createOverlay(childNode: familyPhotoFrame, in: self)
        
        await self.dialogBox?.start(dialogs: DialogResources.office2PhotoFrameSequence, from: self)
        FactoryMethods.removeOverlay(in: self)
        self.isUserInteractionEnabled = true
    }
}

// MARK: Scene's Events
extension OfficeScene {
    
    func startFirstTimeEnteringEventIfNeeded() async {
        guard let gameStateManager else { return }
        
        if !gameStateManager.stateExisted(.momsCallAccepted) {
            isUserInteractionEnabled = false
            await dialogBox?.start(dialog: DialogResources.office1Solo, from: self)
            isUserInteractionEnabled = true
        }
    }
    
    func startInputPinGame() {
        guard gameStateManager?.getState(key: .momsCallAccepted) == nil else { return }
        scenePresenter?.presentInputPinMiniGame()
    }
    
    // State updates according game event.
    func updateMomCallEventState(callAccepted: Bool) {
        guard let gameStateManager else { return }
        gameStateManager.setState(key: .momsCallAccepted, value: .boolValue(callAccepted))
    }
}
