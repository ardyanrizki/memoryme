//
//  SceneChangeZoneIdentifier.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit

enum SceneChangeZoneIdentifier: String, CaseIterable {
    case toOffice = "toOffice"
    case toBedroom = "toBedroom"
    case toBar = "toBar"
    case toHospital = "toHospital"
    case toMainRoomFromOffice = "toMainRoomFromOffice"
    case toMainRoomFromBedroom = "toMainRoomFromBedroom"
    case toMainRoomFromHospital = "toMainRoomFromHospital"
    case toMainRoomFromBar = "toMainRoomFromBar"
    
    func getNode(from scene: SKScene) -> SceneChangeZoneNode? {
        let node = scene.childNode(withName: self.rawValue) as? SceneChangeZoneNode
        node?.identifier = self
        node?.setup()
        return node
    }
}

