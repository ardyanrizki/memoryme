//
//  PresentableSceneProtocol.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

/// A protocol for defining scenes that can be presented in the game.
protocol PresentableSceneProtocol {
    
    /// The type of the scene that conforms to `SKScene`.
    associatedtype T: SKScene
    
    /// Creates and returns a shared instance of the scene with the specified playableCharacter position.
    ///
    /// - Parameter playerPosition: The initial position of the playableCharacter character in the scene.
    /// - Returns: An optional shared instance of the scene, or `nil` if it couldn't be created.
    static func sharedScene(playerPosition: CharacterPosition) -> T?
}
