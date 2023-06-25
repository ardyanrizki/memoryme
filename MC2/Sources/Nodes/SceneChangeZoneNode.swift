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
        physicsBody?.categoryBitMask = PhysicsCategory.sceneChangeZone
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        zPosition = 2
        alpha = 0.5
    }
    
    func moveScene(with sceneManager: SceneManagerProtocol?) {
        guard let identifier else { return }
        switch identifier {
        case .toMainRoom:
            sceneManager?.presentMainRoomScene()
        case .toOffice:
            sceneManager?.presentOfficeRoomScene()
        case .toBedroom:
            sceneManager?.presentBedroomScene()
        case .toBar:
            sceneManager?.presentBarScene()
        case .toHospital:
            sceneManager?.presentHospitalRoomScene()
        }
    }
}
