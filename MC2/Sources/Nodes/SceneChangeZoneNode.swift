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
        alpha = 0.5
    }
    
    func moveScene(with sceneManager: SceneManagerProtocol?) {
        guard let identifier else { return }
        switch identifier {
        case .toOffice:
            sceneManager?.presentOfficeRoomScene()
        case .toBedroom:
            sceneManager?.presentBedroomScene()
        case .toBar:
            sceneManager?.presentBarScene()
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
