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
        if node.position.y < (player?.node?.position.y)! {
            node.zPosition = 20
        } else {
            if node.zPosition > 10 {
                node.zPosition = 10
            }
        }
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
                // TODO: do action related to macbook
                print("Touch bubble at Macbook")
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

extension OfficeRoomScene {
    func showPhotoFrame() {
        let texture = SKTexture(imageNamed: TextureResources.familyPhotoFrame)
        let familyPhotoFrame = SKSpriteNode(texture: texture)
        familyPhotoFrame.position = CGPoint(x: frame.midX, y: frame.midY)
        familyPhotoFrame.zPosition = 100
        familyPhotoFrame.size.width = 400
        familyPhotoFrame.size.height = 600
        familyPhotoFrame.alpha = 1
        
        FactoryMethods.createOverlay(childNode: familyPhotoFrame, in: self)
        
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.office_1_photoframe_seq1,
            DialogResources.office_2_photoframe_seq2,
        ], from: self, completion: {
            FactoryMethods.removeOverlay(in: self)
        })
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
}
