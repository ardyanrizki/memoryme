//
//  Cooldown.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 03/07/23.
//

import Foundation

/// A simple cooldown manager to control the execution of actions with a cooldown period.
class Cooldown {
    
    /// The shared instance of `Cooldown`.
    static let shared = Cooldown()
    
    /// Indicates whether the cooldown is currently active.
    private var isOnCooldown = false
    
    /// Starts a cooldown period for the specified duration and executes an action when the cooldown is over.
    ///
    /// - Parameters:
    ///   - duration: The duration of the cooldown period.
    ///   - action: The action to be executed when the cooldown is over..
    func startCooldown(duration: TimeInterval, action: @escaping () -> Void) {
        // If already on cooldown, do nothing.
        guard !isOnCooldown else { return }

        // Execute the action with the current cooldown state.
        action()

        // Set the cooldown state to true.
        isOnCooldown = true

        // Schedule a task to reset the cooldown state after the specified duration.
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isOnCooldown = false
        }
    }
}
