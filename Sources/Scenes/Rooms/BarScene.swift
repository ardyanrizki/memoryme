//
//  BarScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

/// The scene representing the bar in the game.
class BarScene: ExplorationScene, PresentableSceneProtocol {
    
    // MARK: - Renderable Items
    
    /// An array of renderable items in the bar scene.
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            BarItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    // MARK: - Shared Scene Initialization
    
    /// Creates and returns a shared instance of the bar scene.
    /// - Parameter playerPosition: The initial position of the playableCharacter character.
    /// - Returns: A shared instance of the bar scene.
    static func sharedScene(playerPosition position: CharacterPosition) -> BarScene? {
        let scene = BarScene(fileNamed: Constants.barScene)
        scene?.setup(playerPosition: position)
        return scene
    }
    
    // MARK: - Characters
    
    /// The bartender character in the bar scene.
    var bartender: Character? {
        characters.first{ $0.identifier == Constants.bartenderName }
    }
    
    // MARK: - Scene Lifecycle
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        Task {
            if isFirstEnter {
                await firstEnterDialog()
            }
            
            if !isFirstEnter, !isBartenderEventOccurred {
                await startBartenderEvent()
            }
        }
    }
    
    override func playerDidContact(with item: any RenderableItem, node: ItemNode) {
        if item as? BarItem == .radioBar {
            node.isBubbleShown = stateManager?.getState(key: .strangerSaved) != nil ? false : true
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
                sceneManager?.presentRadioTunerMiniGame()
            }
        } else {
            FactoryMethods.removeOverlay(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

// MARK: - Scene's Events
extension BarScene {
    
    /// Checks if it is the first entry into the bar scene.
    private var isFirstEnter: Bool {
        stateManager?.getState(key: .strangerSaved) == nil
    }
    
    /// Checks if the stranger is saved in the bar scene.
    private var isStrangerSaved: Bool {
        stateManager?.getState(key: .strangerSaved) == .boolValue(true)
    }
    
    /// Checks if the bartender event has occurred in the bar scene.
    private var isBartenderEventOccurred: Bool {
        stateManager?.getState(key: .bartenderEventOccurred) == .boolValue(true)
    }
    
    /// Presents the dialogues for the first entry into the bar scene.
    private func firstEnterDialog() async {
        isUserInteractionEnabled = false
        await dialogBox?.start(dialog: DialogResources.bar1Solo, from: self)
        isUserInteractionEnabled = true
    }
    
    /// Initiates the bartender event in the bar scene.
    private func startBartenderEvent() async {
        isUserInteractionEnabled = false
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        await enterBartender()
        await bartenderDialogs()
        updateState()
        isUserInteractionEnabled = true
    }
    
    /// Assigns the bartender character to the scene.
    private func assignBartenderToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.barBartenderHidingSpot.rawValue) else { return nil }
        let character = FactoryMethods.createBartender(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
    
    /// Enters the bartender character into the scene.
    private func enterBartender() async {
        let bartender = assignBartenderToScene()
        await dispatch(character: bartender, walkTo: .barBartenderSpot)
    }
    
    /// Presents the dialogues for the bartender character.
    private func bartenderDialogs() async {
        var dialogs = DialogResources.bar4BartenderAlt2Sequence
        if isStrangerSaved {
            dialogs = DialogResources.bar4BartenderAlt1Sequence
        }
        await dialogBox?.start(dialogs: dialogs, from: self)
    }
    
    /// Updates the game state to indicate the bartender event has occurred.
    private func updateState() {
        stateManager?.setState(key: .bartenderEventOccurred, value: .boolValue(true))
    }
    
    /// Updates the game state to indicate whether the stranger is saved.
    /// - Parameter strangerSaved: A boolean value indicating whether the stranger is saved.
    func updateSaveStrangerEventState(strangerSaved: Bool) {
        guard let stateManager else { return }
        stateManager.setState(key: .strangerSaved, value: .boolValue(strangerSaved))
    }
}
