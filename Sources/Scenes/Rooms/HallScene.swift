//
//  HallScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class HallSceneBlocker: SceneBlockerProtocol {
    
    var completion: ((SceneTransition) -> Void)?
    
    var isHospitalDoorOpened: Bool = false
    
    init(withCompletion completion: @escaping (SceneTransition) -> Void) {
        self.completion = completion
    }
    
    func isAllowToPresentScene(_ identifier: SceneTransition) -> Bool {
        switch identifier {
        case .fromHallToOffice, .fromHallToBedroom:
            return true
        case .fromHallToHospital:
            return isHospitalDoorOpened
        default:
            return true
        }
    }
    
    func sceneBlockedHandler(_ identifier: SceneTransition) {
        completion?(identifier)
    }
}

class HallScene: ExplorationScene, PresentableSceneProtocol {
    
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            MainRoomItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    typealias T = HallScene
    
    static func sharedScene(playerPosition: CharacterPosition) -> HallScene? {
        let scene = HallScene(fileNamed: Constants.hallScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    func setupSceneBlocker() {
        let mainRoomSceneBlocker = HallSceneBlocker(withCompletion: { identifier in
            Cooldown.shared.startCooldown(duration: 10) {
                if identifier == .fromHallToHospital {
                    Task {
                        await self.doorDialog()
                        
                        if self.memoriesCollected == 3 {
                            (self.sceneBlocker as? HallSceneBlocker)?.isHospitalDoorOpened = true
                        }
                    }
                }
            }
            
        })
        
        sceneBlocker = mainRoomSceneBlocker
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupSceneBlocker()
        startOpeningEventIfNeeded()
        itemsChangeEvent()
    }

    override func playerDidContact(with item: any RenderableItem, node: ItemNode) {
        node.isBubbleShown = false
        
        if item as? MainRoomItem == .mainDesk {
            node.isBubbleShown = true
        }
        
        if item as? MainRoomItem == .radioTable {
            node.isBubbleShown = true
        }
        
        if item as? MainRoomItem == .vase {
            node.isBubbleShown = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == SharingItem.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else {
                return
            }
            
            switch(parentNode.name) {
            case MainRoomItem.vase.rawValue:
                vaseDialog()
            case MainRoomItem.mainDesk.rawValue:
                deskDialog()
            case MainRoomItem.radioTable.rawValue:
                radioDialog()
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
extension HallScene {
    
    var memoriesCollected: Int {
        return stateManager?.getStates(of: [
            .momsCallAccepted,
            .friendsPhotosKept,
            .strangerSaved
        ]).count ?? 0
    }
    
    var isOpening: Bool {
        stateManager?.getState(key: .sceneActivity) == .sceneActivityValue(.opening)
    }
    
    var isStrangerSaved: Bool {
        stateManager?.getState(key: .strangerSaved) == .boolValue(true)
    }
    
    var isMomsCallAccepted: Bool {
        stateManager?.getState(key: .momsCallAccepted) == .boolValue(true)
    }
    
    func startOpeningEventIfNeeded() {
        if isOpening {
            touchEventsEnabled = false
            playableCharacter?.lay(completion: {
                Task {
                    await self.dialogBox?.start(dialogs: DialogResources.opening1SoloSequence, from: self)
                    self.touchEventsEnabled = true
                }
            })
            stateManager?.setState(key: .sceneActivity, value: .sceneActivityValue(.exploring))
        }
    }
    
    func itemsChangeEvent() {
        adjustOfficeDeskForMomCallAndPhotoAlbumEvent()
        adjustBroomForPhotoAlbumEvent()
        adjustRadioTableForStrangerEvent()
        adjustVaseForAllMemories()
        adjustDoorForAllMemories()
        adjustWindowsForAllMemories()
    }
    
    // State updates according game event.
    func adjustBroomForPhotoAlbumEvent() {
        guard let stateManager else { return }
        let broom = interactableItems.first { $0.node?.renderableItem as? MainRoomItem == .broom }
        
        if stateManager.stateExisted(.friendsPhotosKept),
           stateManager.getState(key: .friendsPhotosKept) == .boolValue(false)
        {
            broom?.showPhysicsBody()
            return
        }
        
        broom?.hidePhysicsBody()
    }
    
    // State updates according game event.
    func adjustOfficeDeskForMomCallAndPhotoAlbumEvent() {
        guard let stateManager else { return }
        let mainDesk = interactableItems.first { $0.node?.renderableItem as? MainRoomItem == .mainDesk }
        
        if stateManager.stateExisted(.momsCallAccepted) {
            mainDesk?.showPhysicsBody()
            if isMomsCallAccepted {
                mainDesk?.textureType = .opened
            } else {
                mainDesk?.textureType = .closed
            }
            return
        }
        
        if stateManager.stateExisted(.friendsPhotosKept) {
            mainDesk?.showPhysicsBody()
            mainDesk?.textureType = .normal
            return
        }
        
        mainDesk?.hidePhysicsBody()
    }
    
    // State updates according game event.
    func adjustRadioTableForStrangerEvent() {
        let radioTable = interactableItems.first { $0.node?.renderableItem as? MainRoomItem == .radioTable }
        
        guard let stateManager else { return }
        // If saved, show radio in desk.
        if stateManager.getState(key: .strangerSaved) == .boolValue(true) {
            radioTable?.showPhysicsBody()
        } else {
            radioTable?.hidePhysicsBody()
        }
    }
    
    // State updates according game event.
    func adjustVaseForAllMemories() {
        guard let vase = interactableItems.first (where: { $0.node?.renderableItem as? MainRoomItem == .vase }) else { return }
        
        switch memoriesCollected {
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
    func adjustDoorForAllMemories() {

        guard let door = interactableItems.first (where: { $0.node?.renderableItem as? SharingItem == .upperDoor }) else { return }
        
        switch memoriesCollected {
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
    
    func adjustWindowsForAllMemories() {
        let windows = interactableItems.filter({ $0.node?.renderableItem as? MainRoomItem == .mainWindow })
        guard windows.count > 1 else { return }
        
        var openedWindowCount = 0
        
        switch memoriesCollected {
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
    
    func vaseDialog() {
        Task {
            await dialogBox?.start(dialog: DialogResources.main7Vase, from: self)
        }
    }
    
    func deskDialog() {
        Task {
            if isMomsCallAccepted {
                await dialogBox?.start(dialog: DialogResources.main1OfficeDeskAlt1, from: self)
                return
            }
            
            if stateManager?.stateExisted(.momsCallAccepted) == true {
                await dialogBox?.start(dialog: DialogResources.main4PhotoAlbumAlt2, from: self)
                return
            }
        
            if stateManager?.stateExisted(.friendsPhotosKept) == true {
                await dialogBox?.start(dialog: DialogResources.main3PhotoAlbumAlt1, from: self)
                return
            }
        }
    }
    
    func radioDialog() {
        Task {
            if isStrangerSaved {
                await dialogBox?.start(dialog: DialogResources.main5RadioAlt1, from: self)
            } else {
                await dialogBox?.start(dialog: DialogResources.main6RadioAlt2, from: self)
            }
        }
    }
    
    func doorDialog() async {
        if memoriesCollected < 3 {
            await dialogBox?.start(dialog: DialogResources.main8ScribbleDoor, from: self)
        } else {
            await dialogBox?.start(dialog: DialogResources.main9ManifestedDoor, from: self)
        }
    }
    
}

// MARK: StateManagerDelegate
extension HallScene: StateManagerDelegate {
    
    func didUpdate(_ variable: GameStateKey?, value: GameStateValue?) {
        // Use this function if need to trigger action everytime any state changed.
    }
    
}
