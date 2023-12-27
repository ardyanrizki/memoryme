//
//  SceneTransition.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit

/**
 Enumerates various scene transitions within the game.
 */
enum SceneTransition: String, CaseIterable {
    case fromHallToOffice
    case fromHallToBedroom
    case fromHallToBar
    case fromHallToHospital
    case fromOfficeToMain
    case fromBedroomToMain
    case fromHospitalToMain
    case fromBarToMain
    
    /**
     Retrieves a SceneTransitionNode from the specified SKScene based on the current transition.
     
     - Parameter scene: The SKScene from which to obtain the SceneTransitionNode.
     
     - Returns: A SceneTransitionNode if found, or nil.
     */
    func getNode(from scene: SKScene) -> SceneTransitionNode? {
        let node = scene.childNode(withName: rawValue) as? SceneTransitionNode
        node?.identifier = self
        node?.setup()
        node?.zPosition = 20
        return node
    }
}
