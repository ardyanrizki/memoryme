//
//  PositionIdentifier.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

enum PositionIdentifier: String, CaseIterable {
    case mainRoomStart = "mainRoomStart"
    case mainRoomOfficeDoor = "mainRoomOfficeDoor"
    case mainRoomBedroomDoor = "mainRoomBedroomDoor"
    case mainRoomHospitalDoor = "mainRoomHospitalDoor"
    case mainRoomBarDoor = "mainRoomBarDoor"
    case officeEntrance = "officeEntrance"
    case hospitalEntrance = "hospitalEntrance"
    case barEntrance = "barEntrance"
    case bedroomEntrance = "bedroomEntrance"
    case computerSpot = "computerSpot"
    case bedroomCenter = "bedroomCenter"
    case photoAlbumSpot = "photoAlbumSpot"
    
    func getNode(from scene: SKScene) -> PositionNode? {
        let node = scene.childNode(withName: self.rawValue) as? PositionNode
        node?.identifier = self
        return node
    }
}
