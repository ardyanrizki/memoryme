//
//  SceneChangeZoneNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class SceneChangeZoneNode: SKSpriteNode {
    var identifier: SceneChangeZoneIdentifier?
    
    func setup() {
        physicsBody = SKPhysicsBody(rectangleOf: self.frame.size)
        physicsBody?.categoryBitMask = PhysicsType.sceneChangeZone.rawValue
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        zPosition = 2
#if DEBUG
        color = .blue
        alpha = 0.5
#else
        alpha = 0
#endif
    }
    
    func moveScene(with sceneManager: SceneManagerProtocol?, sceneBlocker: SceneBlockerProtocol? = nil) {
        guard let identifier else { return }
        
        if let sceneBlocker, sceneBlocker.isAllowToPresentScene(identifier) { return }
        
        switch identifier {
        case .toOffice:
            sceneManager?.presentOfficeRoomScene(playerPosition: .officeEntrance, transition: SKTransition.fade(withDuration: 0.5))
        case .toBedroom:
            sceneManager?.presentBedroomScene()
        case .toBar:
            sceneManager?.presentBarScene(playerPosition: .officeEntrance, transition: SKTransition.fade(withDuration: 0.5))
        case .toHospital:
            sceneManager?.presentHospitalRoomScene()
        case .toMainRoomFromOffice:
            sceneManager?.presentMainRoomScene(playerPosition: .mainRoomOfficeDoor)
        case .toMainRoomFromBedroom:
            sceneManager?.presentMainRoomScene(playerPosition: .mainRoomBedroomDoor)
        case .toMainRoomFromHospital:
            sceneManager?.presentMainRoomScene(playerPosition: .mainRoomHospitalDoor)
        case .toMainRoomFromBar:
            sceneManager?.presentMainRoomScene(playerPosition: .mainRoomBarDoor)
        }
    }
}
