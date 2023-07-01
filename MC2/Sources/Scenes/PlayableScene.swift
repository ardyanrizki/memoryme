//
//  PlayableScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit
import GameplayKit

protocol PlayableSceneProtocol {
    associatedtype T: SKScene
    static func sharedScene(playerPosition: PositionIdentifier) -> T?
}

protocol SceneBlockerProtocol: AnyObject {
    func isAllowToPresentScene(_ identifier: SceneChangeZoneIdentifier) -> Bool
}

class PlayableScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
    /**
     Collection of character position's points.
     */
    var positions: [PositionNode] = [PositionNode]()
    
    /**
     Collection of wall node to define collisions.
     */
    var walls: [WallNode] = [WallNode]()
    
    /**
     Collection of zones that are responsible for triggering scene changes.
     */
    var sceneChangeZones: [SceneChangeZoneNode] = [SceneChangeZoneNode]()
    
    /**
     Collection of interactable items that are responsible for triggering some dialog.
     */
    var interactableItems: [InteractableItem] = [InteractableItem]()
    
    /**
     Player character entity.
     */
    lazy var player: Player? = {
        nil
    }()
    
    weak var gameState: GameState?
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    var sceneBlocker: SceneBlockerProtocol?
    
    private var timeOnLastFrame: TimeInterval = 0
    
    func setup(playerPosition: PositionIdentifier) {
        setupBackground()
        setupPositions()
        setupPlayer(at: playerPosition, from: positions)
        setupDialogBox()
        setupWallsCollision()
        setupSceneChangeZones()
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
        positions = findAllPositionNodesInScene()
    }
    
    /**
     Setup player and assign to scene.
     */
    private func setupPlayer(at position: PositionIdentifier, from positions: [PositionNode]) {
        guard player == nil else { return }
        let positionNode = positions.first { $0.identifier == position }
        let position = positionNode?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        player = FactoryMethods.createPlayer(at: position)
        if let node = player?.node {
            addChild(node)
        }
    }
    
    /**
     Setup dialog box.
     */
    private func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
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
        let itemNodes = findAllItemNodesInScene()
        interactableItems = itemNodes.map { $0.createInteractableItem(in: self, withTextureType: nil) }
    }
    
    /**
     Setup all available sceneChangeZones.
     */
    private func setupSceneChangeZones() {
        sceneChangeZones = findAllSceneChangeZoneNodesInScene()
    }
    
    /**
     Detecting player contact to perform change scene.
     */
    private func detectIntersectsAndChangeScene() {
        sceneChangeZones.forEach { zone in
            if player?.node?.intersects(zone) == true {
                zone.moveScene(with: sceneManager, sceneBlocker: sceneBlocker)
            }
        }
    }
    
    /**
     Detecting player contact with item to perform action.
     */
    private func detectIntersectsWithItem() {
        interactableItems.forEach { item in
            if let itemNode = item.node,
               player?.node?.intersects(itemNode) == true,
               let itemIdentifier = itemNode.identifier {
                if itemNode.position.y < (player?.node?.position.y)! {
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
    
    func timeout(after seconds: TimeInterval, node: SKNode, completion: @escaping () -> Void) {
        let waitAction = SKAction.wait(forDuration: seconds)
        let completionAction = SKAction.run(completion)
        let sequenceAction = SKAction.sequence([waitAction, completionAction])
        node.run(sequenceAction)
    }
    
    private func detectContactsWithItem(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == PhysicsType.character.rawValue ||
            contact.bodyA.categoryBitMask == PhysicsType.character.rawValue) {
            
            if (contact.bodyB.categoryBitMask == PhysicsType.item.rawValue ||
                contact.bodyB.categoryBitMask == PhysicsType.item.rawValue) {
                // This code block will triggered when player contacted with another item.
                var itemNode: ItemNode?
                if contact.bodyA.categoryBitMask == PhysicsType.item.rawValue {
                    itemNode = contact.bodyA.node as? ItemNode
                } else if contact.bodyB.categoryBitMask == PhysicsType.item.rawValue {
                    itemNode = contact.bodyB.node as? ItemNode
                }
                guard let itemNode, let identifier = itemNode.identifier else { return }
                stopPlayerWhenDidContact()
                itemNode.isShowBubble = true
                playerDidContact(with: identifier, node: itemNode)
            }
            
            if (contact.bodyB.categoryBitMask == PhysicsType.wall.rawValue ||
                contact.bodyB.categoryBitMask == PhysicsType.wall.rawValue) {
                stopPlayerWhenDidContact()
            }
        }
    }
    
    private func stopPlayerWhenDidContact() {
        guard let component = player?.component(ofType: ControlComponent.self) as? ControlComponent else { return }
        component.stopWalking()
    }
    
    /**
     Search for all `PositionNode`s in scene.
     */
    private func findAllPositionNodesInScene() -> [PositionNode] {
        return PositionIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `SceneChangeZoneNode`s in scene.
     */
    private func findAllSceneChangeZoneNodesInScene() -> [SceneChangeZoneNode] {
        return SceneChangeZoneIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `ItemNode`s in scene.
     */
    private func findAllItemNodesInScene() -> [ItemNode] {
        var result = [ItemNode]()
        ItemIdentifier.allCases.forEach { identifier in
            result.append(contentsOf: identifier.getAllNodes(from: self))
        }
        return result
    }
    
    // MARK: Overrideable Methods
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {}
    
    func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {}
    
}

// MARK: Overrided methods.
extension PlayableScene {
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = calculateDeltaTime(from: currentTime)
        
        self.update(deltaTime: deltaTime)
    }
    
    func update(deltaTime: TimeInterval) {
        detectIntersectsAndChangeScene()
        detectIntersectsWithItem()
        
        guard let controlComponent = player?.component(ofType: ControlComponent.self) as? ControlComponent else { return }
        
        controlComponent.update(deltaTime: deltaTime)
    }
    
    private func calculateDeltaTime(from currentTime: TimeInterval) -> TimeInterval {
        if timeOnLastFrame.isZero { timeOnLastFrame = currentTime }
        let deltaTime = currentTime - timeOnLastFrame
        timeOnLastFrame = currentTime
        return deltaTime
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
            // Assign player to walk if `dialogBox` not shown.
            player?.walk(to: touchLocation)
        }
    }
    
}

// MARK: SKPhysicsContactDelegate methods.
extension PlayableScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        detectContactsWithItem(contact: contact)
    }
    
}
