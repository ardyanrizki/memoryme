//
//  SceneChangeZoneNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class SceneChangeZoneNode: SKNode {
    var identifier: SceneChangeZoneIdentifier?
    
    func moveScene(with sceneManager: SceneManagerProtocol?) {
        guard let identifier else { return }
        switch identifier {
        case .mainRoomOfficeDoor:
            sceneManager?.presentOfficeRoomScene()
        case .mainRoomBedroomDoor:
            sceneManager?.presentBedroomScene()
        case .mainRoomBarDoor:
            sceneManager?.presentBarScene()
        case .mainRoomHospitalDoor:
            sceneManager?.presentHospitalRoomScene()
        case .officeDoor:
            sceneManager?.presentMainRoomScene()
        case .barDoor:
            sceneManager?.presentMainRoomScene()
        case .hospitalDoor:
            sceneManager?.presentMainRoomScene()
        case .bedroomDoor:
            sceneManager?.presentMainRoomScene()
        }
    }
}
