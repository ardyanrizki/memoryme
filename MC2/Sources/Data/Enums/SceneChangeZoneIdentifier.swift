//
//  SceneChangeZoneIdentifier.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit

enum SceneChangeZoneIdentifier: String, CaseIterable {
    case mainRoomOfficeDoor = "mainRoomOfficeDoor"
    case mainRoomBedroomDoor = "mainRoomBedroomDoor"
    case mainRoomBarDoor = "mainRoomBarDoor"
    case mainRoomHospitalDoor = "mainRoomHospitalDoor"
    case officeDoor = "officeDoor"
    case barDoor = "barDoor"
    case hospitalDoor = "hospitalDoor"
    case bedroomDoor = "bedroomDoor"
    
    func getNode(from scene: SKScene) -> SceneChangeZoneNode? {
        let node = scene.childNode(withName: self.rawValue) as? SceneChangeZoneNode
        node?.identifier = self
        return node
    }
}
