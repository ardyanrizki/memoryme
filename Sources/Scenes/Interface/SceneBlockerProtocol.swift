//
//  SceneBlockerProtocol.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import Foundation

/// A protocol for handling scene transitions and checking whether a scene transition is allowed.
protocol SceneBlockerProtocol {
    
    /// Checks whether the specified scene transition is allowed.
    ///
    /// - Parameter identifier: The identifier of the scene transition.
    /// - Returns: `true` if the scene transition is allowed; otherwise, `false`.
    func isAllowToPresentScene(_ identifier: SceneTransition) -> Bool
    
    /// Handles the case where a scene transition is blocked.
    ///
    /// - Parameter identifier: The identifier of the blocked scene transition.
    func sceneBlockedHandler(_ identifier: SceneTransition)
}
