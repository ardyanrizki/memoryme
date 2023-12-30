//
//  CharacterPosition.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

/**
 Enumerates different character positions in the game environment.
 */
enum CharacterPosition: String, CaseIterable {
    case hallStart
    case hallOfficeDoor
    case hallBedroomDoor
    case hallBarDoor
    case hallHospitalDoor
    
    case officeEntrance
    case officeComputerSpot
    
    case bedroomEntrance
    case bedroomPhotoAlbumSpot
    case bedroomCenter
    
    case barEntrance
    case barRadioSpot
    case barBartenderSpot
    case barBartenderHidingSpot
    
    case hospitalEntrance
    case hospitalSafeEntrance
    case hospitalPlayerBed
    case hospitalMomDestinationSpot
    case hospitalDadDestinationSpot
    case hospitalFriend1DestinationSpot
    case hospitalBartenderDestinationSpot
    case hospitalFriend2DestinationSpot
    
    /**
     Retrieves a PositionNode from the specified SKScene based on the current identifier.
     
     - Parameter scene: The SKScene from which to obtain the PositionNode.
     
     - Returns: A PositionNode if found, or nil.
     */
    func getNode(from scene: SKScene) -> CharacterPositionNode? {
        let node = scene.childNode(withName: rawValue) as? CharacterPositionNode
        node?.identifier = self
        return node
    }
}
