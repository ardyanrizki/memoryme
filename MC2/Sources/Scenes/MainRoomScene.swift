//
//  MainRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class MainRoomScene: PlayableScene, PlayableSceneProtocol {
    
    // TODO: move this value to State Machine
    var touchEventsEnabled: Bool = true
    
    typealias T = MainRoomScene
    
    static func sharedScene(playerPosition: PositionIdentifier) -> MainRoomScene? {
        let scene = MainRoomScene(fileNamed: Constants.mainRoomScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        startOpeningEventIfNeeded()
        changeRoomSceneryAccordingCallEvent()
        changeRoomSceneryAccordingPhotoAlbumEvent()
        changeRoomSceneryAccordingStrangerEvent()
        changeVase()
        changeDoor()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == ItemIdentifier.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else {
                return
            }
            
            switch(parentNode.name) {
            case ItemIdentifier.vase.rawValue:
                self.dialogBox?.start(dialog: DialogResources.opening_8_vase, from: self)
                break
                
            default:
                break
            }
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesCancelled(touches, with: event)
    }
}

// MARK: Scene's Events
extension MainRoomScene {
    
    func startOpeningEventIfNeeded() {
        guard let gameState else { return }
        if gameState.getState(key: .sceneActivity) == .sceneActivityValue(.opening) {
            touchEventsEnabled = false
            player?.lay(completion: {
                self.dialogBox?.startSequence(dialogs: [
                    DialogResources.opening_1_solo_seq1,
                    DialogResources.opening_1_solo_seq2
                ], from: self, completion: {
                    self.touchEventsEnabled = true
                })
            })
            gameState.setState(key: .sceneActivity, value: .sceneActivityValue(.exploring))
        }
    }
    
    // State updates according game event.
    func changeRoomSceneryAccordingCallEvent() {
        guard let gameState else { return }
        // If accepted, show opened frame. else show closed
        if gameState.getState(key: .momsCallAccepted) == .boolValue(true) {
            
        } else {
            
        }
    }
    
    // State updates according game event.
    func changeRoomSceneryAccordingPhotoAlbumEvent() {
        guard let gameState else { return }
        // If kept, show album in desk. else show broom
        if gameState.getState(key: .friendsPhotosKept) == .boolValue(true) {
            let desk = interactableItems.first { $0.node?.identifier == .desk }
        } else {
            
        }
    }
    
    // State updates according game event.
    func changeRoomSceneryAccordingStrangerEvent() {
        guard let gameState else { return }
        // If saved, show radio in desk.
        if gameState.getState(key: .strangerSaved) == .boolValue(true) {
            
        } else {
            
        }
    }
    
    // State updates according game event.
    func changeVase() {
        guard let gameState else { return }
        // Change base change stage: 1...3
        let stage = gameState.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count
        
        switch stage {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    
    // State updates according game event.
    func changeDoor() {
        guard let gameState else { return }
        // Change base change stage: 1...3
        let stage = gameState.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count
        
        switch stage {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    
}

// MARK: GameStateCentralDelegate
extension MainRoomScene: GameStateCentralDelegate {
    
    func didUpdate(_ variable: StateKey?, value: StateValue?) {
        // Use this function if need to trigger action everytime any state changed.
    }
    
}
