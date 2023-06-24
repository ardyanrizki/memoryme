//
//  PlayableScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit
import GameplayKit

class PlayableScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
    /**
     Collection of scene entities.
     */
    var entities: [GKEntity] = [GKEntity]()
    
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
     Player character entity.
     */
    var player: Player?
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    init(playerAt position: PositionIdentifier) {
        super.init()
        setupPositions()
        setupPlayer(at: position, from: positions)
        setupDialogBox()
        setupWallsCollision()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Search the scene for all PositionNode.
     - Warning: Always setup positions before all nodes or entities.
     */
    func setupPositions() {
        positions = findAllPositionNodesInScene()
    }
    
    /**
     Setup player and assign to scene.
     */
    func setupPlayer(at position: PositionIdentifier, from positions: [PositionNode]) {
        guard player == nil else { return }
        let positionNode = positions.first { $0.identifier == position }
        guard let position = positionNode?.position else { return }
        player = FactoryMethods.createPlayer(at: position)
        if let node = player?.node {
            addChild(node)
        }
    }
    
    /**
     Setup dialog box.
     */
    func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
        if let dialogBox {
            addChild(dialogBox)
        }
    }
    
    /**
     Setup walls collision.
     - Warning: Ensure change wall's node custom class to `WallNode`.
     */
    func setupWallsCollision() {
        walls = children.compactMap { $0 as? WallNode }
        walls.forEach { $0.setupPhysicsBodyCollision() }
    }
    
    /**
     Setup all interactable items and add to scene.
     */
    func setupInteractableItems() {
        
    }
    
    /**
     Setup all contact areas and add to scene.
     */
    func setupContactAreas() {
        
    }
    
    /**
     Detecting player contact to perform change scene.
     */
    func detectIntersectsAndChangeScene() {
        sceneChangeZones.forEach { zone in
            if player?.node?.intersects(zone) == true {
                zone.moveScene(with: sceneManager)
            }
        }
    }
    
    /**
     Search for all `PositionNode`s in scene.
     */
    func findAllPositionNodesInScene() -> [PositionNode] {
        return PositionIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `SceneChangeZoneNode`s in scene.
     */
    func findAllSceneChangeZoneNodeInScene() -> [SceneChangeZoneNode] {
        return SceneChangeZoneIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    // MARK: Overrided methods.
    override func update(_ currentTime: TimeInterval) {
        detectIntersectsAndChangeScene()
    }
}
