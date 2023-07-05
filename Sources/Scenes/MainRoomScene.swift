//
//  MainRoomScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class MainRoomSceneBlocker: SceneBlockerProtocol {
    
    var completion: ((SceneChangeZoneIdentifier) -> Void)?
    
    init(withCompletion completion: @escaping (SceneChangeZoneIdentifier) -> Void) {
        self.completion = completion
    }
    
    func isAllowToPresentScene(_ identifier: SceneChangeZoneIdentifier) -> Bool {
        switch identifier {
//        case .toOffice, .toBedroom:
//            return true
        default:
            return true
        }
    }
    
    func sceneBlockedHandler(_ identifier: SceneChangeZoneIdentifier) {
        completion?(identifier)
    }
}

class MainRoomScene: PlayableScene, PlayableSceneProtocol {
    
    typealias T = MainRoomScene
    
    static func sharedScene(playerPosition: PositionIdentifier) -> MainRoomScene? {
        let scene = MainRoomScene(fileNamed: Constants.mainRoomScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    func setupSceneBlocker() {
        sceneBlocker = MainRoomSceneBlocker(withCompletion: { identifier in
            switch identifier {
            case .toBar:
                Cooldown.shared.startCooldown(duration: 5) {
                    if self.touchEventsEnabled {
                        self.touchEventsEnabled = false
                        self.dialogBox?.start(dialog: DialogResources.toBarBlockedFallback, from: self, completion: {
                            self.touchEventsEnabled = true
                        })
                    }
                }
            default:
                break
            }
        })
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSceneBlocker()
        startOpeningEventIfNeeded()
        changeDeskAccordingMomsCallAndPhotoAlbumEvent()
        changeBroomAccordingPhotoAlbumEvent()
        changeRadioTableAccordingStrangerEvent()
        changeVaseAccordingAllMemories()
        changeDoorAccordingAllMemories()
        changeWindowsAccordingAllMemories()
    }
    
    override func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {
        node.isShowBubble = false
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
                self.dialogBox?.start(dialog: DialogResources.opening_8_vase, from: self, completion: {
                    self.isUserInteractionEnabled = false
                })
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
    func changeBroomAccordingPhotoAlbumEvent() {
        guard let gameState else { return }
        let broom = interactableItems.first { $0.node?.identifier == .broom }
        
        if gameState.stateExisted(.friendsPhotosKept),
           gameState.getState(key: .friendsPhotosKept) == .boolValue(false)
        {
            broom?.showPhysicsBody()
            return
        }
        
        broom?.hidePhysicsBody()
    }
    
    // State updates according game event.
    func changeDeskAccordingMomsCallAndPhotoAlbumEvent() {
        guard let gameState else { return }
        let mainDesk = interactableItems.first { $0.node?.identifier == .mainDesk }
        
        if gameState.stateExisted(.momsCallAccepted) {
            mainDesk?.showPhysicsBody()
            if gameState.getState(key: .momsCallAccepted) == .boolValue(true) {
                mainDesk?.textureType = .opened
            } else {
                mainDesk?.textureType = .closed
            }
            return
        }
        
        if gameState.stateExisted(.friendsPhotosKept) {
            mainDesk?.showPhysicsBody()
            mainDesk?.textureType = .normal
            return
        }
        
        mainDesk?.hidePhysicsBody()
    }
    
    // State updates according game event.
    func changeRadioTableAccordingStrangerEvent() {
        let radioTable = interactableItems.first { $0.node?.identifier == .radioTable }
        
        guard let gameState else { return }
        // If saved, show radio in desk.
        if gameState.getState(key: .strangerSaved) == .boolValue(true) {
            radioTable?.showPhysicsBody()
        } else {
            radioTable?.hidePhysicsBody()
        }
    }
    
    // State updates according game event.
    func changeVaseAccordingAllMemories() {
        guard let gameState else { return }
        
        guard let vase = interactableItems.first (where: { $0.node?.identifier == .vase }) else { return }
        
        let stage = gameState.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count
        
        
        switch stage {
        case 0:
            vase.textureType = .ripe
        case 1:
            vase.textureType = .budding
        case 2:
            vase.textureType = .partialBlossom
        case 3:
            vase.textureType = .fullBlossom
        default:
            break
        }
    }
    
    // State updates according game event.
    func changeDoorAccordingAllMemories() {
        guard let gameState else { return }
        
        guard let door = interactableItems.first (where: { $0.node?.identifier == .upperDoor }) else { return }
        
        let stage = gameState.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count
        
        switch stage {
        case 0:
            door.textureType = .sketchy
        case 1:
            door.textureType = .vague
        case 2:
            door.textureType = .clear
        case 3:
            door.textureType = .normal
        default:
            break
        }
    }
    
    func changeWindowsAccordingAllMemories() {
        guard let gameState else { return }
        let windows = interactableItems.filter({ $0.node?.identifier == .mainWindow })
        guard windows.count > 1 else { return }
        let stage = gameState.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count
        var openedWindowCount = 0
        switch stage {
        case 0:
            openedWindowCount = 0
        case 1:
            openedWindowCount = 1
        case 2:
            openedWindowCount = 2
        case 3:
            openedWindowCount = 2
        default:
            openedWindowCount = 0
        }
        windows.forEach { window in
            if openedWindowCount > 0 {
                window.textureType = .opened
                openedWindowCount -= 1
            } else {
                window.textureType = .closed
            }
        }
    }
    
}

// MARK: GameStateCentralDelegate
extension MainRoomScene: GameStateCentralDelegate {
    
    func didUpdate(_ variable: StateKey?, value: StateValue?) {
        // Use this function if need to trigger action everytime any state changed.
    }
    
}
