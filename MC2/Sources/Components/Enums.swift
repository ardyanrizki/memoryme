//
//  Enums.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import Foundation

/// The different directions that an animated character can be facing.
enum CompassDirection: CaseIterable {
    case north
    case east
    case south
    case west
}

/// The different animation states that an animated character can be in.
enum AnimationState {
    case idle
    case walk
    case sit
    case lay
}

struct CharacterPoint {
    static let mainRoomStart = "mainRoomStart"
    static let mainRoomOfficeDoor = "mainRoomOfficeDoor"
    static let mainRoomBedroomDoor = "mainRoomBedroomDoor"
    static let mainRoomHospitalDoor = "mainRoomHospitalDoor"
    static let mainRoomBarDoor = "mainRoomBarDoor"
    static let officeEntrance = "officeEntrance"
    static let hospitalEntrance = "hospitalEntrance"
    static let barEntrance = "barEntrance"
    static let bedroomEntrance = "bedroomEntrance"
}

struct ContactZone {
    static let mainRoomOfficeDoor = "mainRoomOfficeDoor"
    static let mainRoomBedroomDoor = "mainRoomBedroomDoor"
    static let mainRoomBarDoor = "mainRoomBarDoor"
    static let mainRoomHospitalDoor = "mainRoomHospitalDoor"
    static let officeDoor = "officeDoor"
    static let barDoor = "barDoor"
    static let hospitalDoor = "hospitalDoor"
    static let bedroomDoor = "bedroomDoor"
}
