//
//  SceneTransitionNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

/// A custom `SKSpriteNode` representing a scene transition node in the scene.
class SceneTransitionNode: SKSpriteNode {
    
    /// An identifier indicating the scene transition.
    var identifier: SceneTransition?
    
    /// Sets up the physics body for the scene transition node.
    func setup() {
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        physicsBody?.categoryBitMask = PhysicsType.sceneChangeZone.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        zPosition = 20
        
        #if DEBUG
        color = .blue
        alpha = 0.5
        #else
        alpha = 0
        #endif
    }
    
    /// Moves the scene based on the specified scene transition identifier.
    ///
    /// - Parameters:
    ///   - scenePresenter: The `ScenePresenter` responsible for presenting scenes.
    ///   - sceneBlocker: An optional `SceneBlockerProtocol` to check scene transition blocking conditions.
    func moveScene(with scenePresenter: ScenePresenter?, sceneBlocker: SceneBlockerProtocol? = nil) {
        guard let identifier else { return }
        
        if let sceneBlocker, !sceneBlocker.isAllowToPresentScene(identifier) {
            sceneBlocker.sceneBlockedHandler(identifier)
            return
        }
        
        switch identifier {
        case .fromHallToOffice:
            let fade = SKTransition.fade(withDuration: 0.5)
            scenePresenter?.presentOffice(playerPosition: .officeEntrance, transition: fade)
        case .fromHallToBedroom:
            scenePresenter?.presentBedroom(playerPosition: .bedroomEntrance)
        case .fromHallToBar:
            scenePresenter?.presentBar(playerPosition: .barEntrance, transition: SKTransition.fade(withDuration: 0.5))
        case .fromHallToHospital:
            scenePresenter?.presentHospital()
        case .fromOfficeToMain:
            scenePresenter?.presentHall(playerPosition: .hallOfficeDoor)
        case .fromBedroomToMain:
            scenePresenter?.presentHall(playerPosition: .hallBedroomDoor)
        case .fromHospitalToMain:
            scenePresenter?.presentHall(playerPosition: .hallHospitalDoor)
        case .fromBarToMain:
            scenePresenter?.presentHall(playerPosition: .hallBarDoor)
        }
    }
}
