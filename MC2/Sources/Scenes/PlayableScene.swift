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
    static func sharedScene(playerAt position: PositionIdentifier) -> T?
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
    var interactiveItem: [InteractiveItem] = [InteractiveItem]()
    
    /**
     Player character entity.
     */
    lazy var player: Player? = {
        nil
    }()
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    func setup(playerAt position: PositionIdentifier) {
        print(type(of: self) == TestScene.self, "<<")
        setupBackground()
        setupPositions()
        setupPlayer(at: position, from: positions)
        setupDialogBox()
        setupWallsCollision()
        setupSceneChangeZones()
        setupInteractiveItems()
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
    private func setupInteractiveItems() {
        let itemNodes = findAllItemNodesInScene()
        interactiveItem = itemNodes.map { $0.createInteractiveItem(from: self) }
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
                zone.moveScene(with: sceneManager)
            }
        }
    }
    
    /**
     Detecting player contact with item to perform action.
     */
    private func detectIntersectsWithItem() {
        interactiveItem.forEach { item in
            if let itemNode = item.node,
               player?.node?.intersects(itemNode) == true,
               let itemIdentifier = itemNode.identifier {
                playerDidIntersects(with: itemIdentifier)
            }
        }
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
        return ItemIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    func playerDidIntersects(with itemIdentifier: ItemIdentifier) {}

}

// MARK: Overrided methods.
extension PlayableScene {
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        detectIntersectsAndChangeScene()
        detectIntersectsWithItem()
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
