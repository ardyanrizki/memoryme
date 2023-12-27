//
//  BarScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class BarScene: RoomScene, PresentableSceneProtocol {
    
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            BarItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    typealias T = BarScene
    
    static func sharedScene(playerPosition position: CharacterPosition) -> BarScene? {
        let scene = BarScene(fileNamed: Constants.barScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    var bartender: Character? {
        characters.first{ $0.identifier == Constants.bartenderName }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        Task {
            await firstEnterBarEventIfNeeded()
            setupBartender()
            
            if let gameStateManager, gameStateManager.stateExisted(.strangerSaved) {
                startTheBartenderEvent()
            }
        }
    }
    
    func setupBartender() {
        guard let hidingSpot = childNode(withName: CharacterPosition.barBartenderHidingSpot.rawValue) else { return }
        addCharacter(FactoryMethods.createBartender(at: hidingSpot.position))
    }
    
    override func playerDidContact(with item: any RenderableItem, node: ItemNode) {
        if item as? BarItem == .radioBar {
            node.isBubbleShown = gameStateManager?.getState(key: .strangerSaved) != nil ? false : true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        if touchedNode!.name == SharingItem.bubble.rawValue {
            // Indicate touched node does not have any parent
            guard let parentNode = touchedNode?.parent else {
                return
            }
            
            if parentNode.name == BarItem.radioBar.rawValue {
                scenePresenter?.presentRadioTunerMiniGame()
            }
        } else {
            FactoryMethods.removeOverlay(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

// MARK: Scene's Events
extension BarScene {
    
    private func firstEnterBarEventIfNeeded() async {
        guard gameStateManager?.getState(key: .strangerSaved) == nil else { return }
        isUserInteractionEnabled = false
        await dialogBox?.start(dialog: DialogResources.bar1Solo, from: self)
        isUserInteractionEnabled = true
    }
    
    private func startPlayRadioEvent() {
        
    }
    
    private func startRadioGame() {
        
    }
    
    private func startTheStrangerSnapshots() {
        
    }
    
    private func startTheBartenderEvent() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.bartenderWalk()
        }
    }
    
    private func bartenderWalk() {
        guard let bartenderSpot = childNode(withName: CharacterPosition.barBartenderSpot.rawValue) else { return }
        isUserInteractionEnabled = false
        bartender?.walk(to: bartenderSpot.position, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                Task {
                    await self.bartenderTalk()
                    self.isUserInteractionEnabled = true
                }
            }
        })
    }
    
    private func bartenderTalk() async {
        var dialogs = DialogResources.bar4BartenderAlt2Sequence
        if gameStateManager?.getState(key: .strangerSaved) == .boolValue(true) {
            dialogs = DialogResources.bar4BartenderAlt1Sequence
        }
        await dialogBox?.start(dialogs: dialogs, from: self, withInterval: 1.5)
    }
    
    // State update according game event.
    func updateSaveStrangerEventState(strangerSaved: Bool) {
        guard let gameStateManager else { return }
        gameStateManager.setState(key: .strangerSaved, value: .boolValue(strangerSaved))
    }
    
}
