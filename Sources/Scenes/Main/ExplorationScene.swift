//
//  ExplorationScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit
import GameplayKit
import AVFoundation

class ExplorationScene: GameScene {
    
    var touchEventsEnabled: Bool = true
    
    /**
     Collection of character position's points.
     */
    var positions: [CharacterPositionNode] = [CharacterPositionNode]()
    
    /**
     Collection of wall node to define collisions.
     */
    var walls: [WallNode] = [WallNode]()
    
    /**
     Collection of zones that are responsible for triggering scene changes.
     */
    var sceneTransitionNodes: [SceneTransitionNode] = [SceneTransitionNode]()
    
    /**
     Collection of interactable items that are responsible for triggering some dialog.
     */
    var interactableItems: [InteractableItem] = [InteractableItem]()
    
    var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            MainRoomItem.allCases as [any RenderableItem],
            BedroomItem.allCases as [any RenderableItem],
            OfficeItem.allCases as [any RenderableItem],
            BarItem.allCases as [any RenderableItem],
            HospitalItem.allCases as [any RenderableItem]
        ].flatMap { $0 }
    }
    
    /**
     Player character entity.
     */
    lazy var playableCharacter: Character? = nil
    
    var characters = [Character]()
    
    var audioEffectPlayer: AVAudioPlayer!
    
    private var timeOnLastFrame: TimeInterval = 0
    
    func setup(playerPosition: CharacterPosition) {
        setupBackground()
        setupPositions()
        setupPlayer(at: playerPosition, from: positions)
        setupDialogBox()
        setupWallsCollision()
        setupSceneTransition()
        setupInteractableItems()
    }
    
    /**
     Setting up the background's z index.
     */
    private func setupBackground() {
        let background = childNode(withName: Constants.background)
        background?.zPosition = 0
    }
    
    /**
     Search the scene for all PositionNode.
     - Warning: Always setup positions before all nodes or entities.
     */
    private func setupPositions() {
        positions = findCharacterPositionNodesInScene()
    }
    
    /**
     Setup playableCharacter and assign to scene.
     */
    func setupPlayer(at position: CharacterPosition, from positions: [CharacterPositionNode]) {
        guard playableCharacter == nil else { return }
        let positionNode = positions.first { $0.identifier == position }
        let position = positionNode?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        playableCharacter = FactoryMethods.createPlayer(at: position)
        if let node = playableCharacter?.node {
            addChild(node)
        }
    }
    
    func addCharacter(_ character: Character) {
        if let node = character.node {
            characters.append(character)
            addChild(node)
        }
    }
    
    /// Dispatches the character to the specified position.
    func dispatch(character: Character?, walkTo position: CharacterPosition) async {
        guard let spot = childNode(withName: position.rawValue) else { return }
        await withCheckedContinuation { continuation in
            character?.walk(to: spot.position, itemNode: nil, completion: {
                continuation.resume()
            })
        }
    }
    
    /**
     Setup walls collision.
     - Warning: Ensure change wall's node custom class to `WallNode`.
     */
    private func setupWallsCollision() {
        walls = children.compactMap { $0 as? WallNode }
        walls.forEach { $0.setupPhysicsBody() }
    }
    
    /**
     Setup all interactable items and add to scene.
     */
    private func setupInteractableItems() {
        let itemNodes = findItemNodesInScene()
        interactableItems = itemNodes.map { $0.createInteractableItem(in: self, withTextureType: nil) }
    }
    
    /**
     Setup all available sceneTransitionNodes.
     */
    private func setupSceneTransition() {
        sceneTransitionNodes = findSceneTransitionNodesInScene()
    }
    
    /**
     Detecting playableCharacter contact to perform change scene.
     */
    private func detectIntersectsAndChangeScene() {
        sceneTransitionNodes.forEach { zone in
            if playableCharacter?.node?.intersects(zone) == true {
                zone.moveScene(with: sceneManager, sceneBlocker: sceneBlocker)
            }
        }
    }
    
    /**
     Detecting playableCharacter contact with item to perform action.
     */
    private func detectIntersectsWithItem() {
        interactableItems.forEach { item in
            if let itemNode = item.node,
               playableCharacter?.node?.intersects(itemNode) == true,
               let itemIdentifier = itemNode.renderableItem {
                if itemNode.position.y < (playableCharacter?.node?.position.y)! {
                    itemNode.zPosition = 20
                } else {
                    if itemNode.zPosition > 10 {
                        itemNode.zPosition = 10
                    }
                }
                playerDidIntersect(with: itemIdentifier, node: itemNode)
            }
        }
    }
    
    private func calculateDeltaTime(from currentTime: TimeInterval) -> TimeInterval {
        if timeOnLastFrame.isZero { timeOnLastFrame = currentTime }
        let deltaTime = currentTime - timeOnLastFrame
        timeOnLastFrame = currentTime
        return deltaTime
    }
    
    func update(deltaTime: TimeInterval) {
        detectIntersectsAndChangeScene()
        detectIntersectsWithItem()
        
        let playerControlComponent = playableCharacter?.component(ofType: ControlComponent.self) as? ControlComponent
        playerControlComponent?.update(deltaTime: deltaTime)
        
        for character in characters {
            let characterControlComponent = character.component(ofType: ControlComponent.self)
            characterControlComponent?.update(deltaTime: deltaTime)
        }
    }
    
    private func stopPlayerWhenDidContact() {
        guard let component = playableCharacter?.component(ofType: ControlComponent.self) as? ControlComponent else { return }
        component.stopWalking()
    }
    
    /**
     Search for all `PositionNode`s in scene.
     */
    private func findCharacterPositionNodesInScene() -> [CharacterPositionNode] {
        return CharacterPosition.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `SceneTransitionNode`s in scene.
     */
    private func findSceneTransitionNodesInScene() -> [SceneTransitionNode] {
        return SceneTransition.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `ItemNode`s in scene.
     */
    private func findItemNodesInScene() -> [ItemNode] {
        var result = [ItemNode]()
        renderableItems.forEach { item in
            result.append(contentsOf: item.findNodes(from: self))
        }
        return result
    }
    
    // MARK: Scene Audio
    func playAmbienceBGM() {
        audioManager?.play(audioFile: .ambience, type: .background)
    }
    
    // MARK: Overrideable Methods
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    func playerDidIntersect(with item: any RenderableItem, node: ItemNode) {}
    
    func playerDidContact(with item: any RenderableItem, node: ItemNode) {}
    
}

// MARK: Overrided methods.
extension ExplorationScene {
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
        playAmbienceBGM()
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = calculateDeltaTime(from: currentTime)
        
        self.update(deltaTime: deltaTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        dialogBox?.handleTouch(on: touchLocation)
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        if dialogBox?.isShowing == false, (dialogBox?.isShowing == false || dialogBox?.contains(touchLocation) == false) {
            
            let itemNode = atPoint(touchLocation) as? ItemNode
            // Assign playableCharacter to walk if `dialogBox` not shown.
            playableCharacter?.walk(to: touchLocation, itemNode: itemNode)
        }
    }
    
    private func getItemNode(from contact: SKPhysicsContact) -> ItemNode? {
        if (contact.bodyA.categoryBitMask == PhysicsType.item.rawValue ||
            contact.bodyB.categoryBitMask == PhysicsType.item.rawValue) {
            // This code block will triggered when player contacted with another item.
            var itemNode: ItemNode?
            if contact.bodyA.categoryBitMask == PhysicsType.item.rawValue {
                itemNode = contact.bodyA.node as? ItemNode
            } else if contact.bodyB.categoryBitMask == PhysicsType.item.rawValue {
                itemNode = contact.bodyB.node as? ItemNode
            }
            guard let itemNode else { return nil }
            return itemNode
        }
        return nil
    }
    
}

// MARK: SKPhysicsContactDelegate methods.
extension ExplorationScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        playableCharacter?.didBeginContact(contact)
        
        if  let itemNode = getItemNode(from: contact),
            let identifier = itemNode.renderableItem {
            itemNode.isBubbleShown = true
            playerDidContact(with: identifier, node: itemNode)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        playableCharacter?.didEndContact(contact)
    }
    
}
