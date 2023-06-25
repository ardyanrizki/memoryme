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
    static func sharedScene(playerAt: PositionIdentifier) -> T?
}

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
    lazy var player: Player? = {
        nil
    }()
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    func setup(playerAt position: PositionIdentifier) {
        print(type(of: self) == TestScene.self, "<<")
        setupPositions()
        setupPlayer(at: position, from: positions)
        setupDialogBox()
        setupWallsCollision()
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
        dialogBox?.show(dialog: DialogResources.strangeVase, from: self)
    }
    
    /**
     Setup walls collision.
     - Warning: Ensure change wall's node custom class to `WallNode`.
     */
    private func setupWallsCollision() {
        walls = children.compactMap { $0 as? WallNode }
        walls.forEach { $0.setupPhysicsBodyCollision() }
    }
    
    /**
     Setup all interactable items and add to scene.
     */
    private func setupInteractableItems() {
        
    }
    
    /**
     Setup all contact areas and add to scene.
     */
    private func setupContactAreas() {
        
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
    private func findAllSceneChangeZoneNodeInScene() -> [SceneChangeZoneNode] {
        return SceneChangeZoneIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
   
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    // MARK: Overrided methods.
    override func didMove(to view: SKView) {
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        detectIntersectsAndChangeScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if dialogBox?.contains(touchLocation) == true {
            // Skip dialog box typing animation if running.
            dialogBox?.skipTyping()
        } else {
            // Hide dialog box if shown.
            dialogBox?.hide()
        }
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        if dialogBox?.isShowing == false {
            // Assign player to walk if dialogBox is not shown.
            player?.walk(to: touchLocation)
        }
    }
}
