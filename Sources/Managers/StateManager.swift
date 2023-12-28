//
//  StateManager.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 27/06/23.
//

import Foundation

/**
 A protocol for delegates to receive updates from the StateManager.
 */
protocol StateManagerDelegate: AnyObject {
    /**
     Informs the delegate about changes in the game state.
     
     - Parameters:
        - key: The key associated with the updated state variable.
        - value: The new value of the state variable.
     */
    func didUpdate(_ key: GameStateKey?, value: GameStateValue?)
}

/**
 Manages the game state and provides methods to modify and retrieve state variables.
 */
class StateManager {
    
    /// Dictionary to store game state variables.
    private var states: [GameStateKey: GameStateValue] = [:]
    
    /// Delegate to receive updates about changes in game state.
    var delegate: StateManagerDelegate?
    
    /**
     Sets the value for a specified state variable.
     
     - Parameters:
        - key: The key associated with the state variable.
        - value: The new value for the state variable.
     */
    func setState(key: GameStateKey, value: GameStateValue) {
        states[key] = value
        delegate?.didUpdate(key, value: value)
    }
    
    /**
     Retrieves the value for a specified state variable.
     
     - Parameters:
        - key: The key associated with the state variable.
     
     - Returns: The value of the state variable, or `nil` if the key is not found.
     */
    func getState(key: GameStateKey) -> GameStateValue? {
        return states[key]
    }
    
    /**
     Retrieves a subset of game states based on provided keys.
     
     - Parameters:
        - stateKeys: An optional array of keys for the desired state variables. If `nil`, returns all states.
     
     - Returns: A dictionary containing the specified state variables and their values.
     */
    func getStates(of stateKeys: [GameStateKey]? = nil) -> [GameStateKey: GameStateValue] {
        if let stateKeys = stateKeys {
            return states.filter { stateKeys.contains($0.key) }
        }
        return states
    }
    
    /**
     Removes a specified state variable.
     
     - Parameters:
        - key: The key associated with the state variable to be removed.
     */
    func removeState(key: GameStateKey) {
        states[key] = nil
        delegate?.didUpdate(key, value: nil)
    }
    
    /**
     Removes all state variables.
     */
    func removeAllStates() {
        states.removeAll()
        delegate?.didUpdate(nil, value: nil)
    }
    
    /**
     Checks if a state variable exists.
     
     - Parameters:
        - stateKey: The key associated with the state variable.
     
     - Returns: `true` if the state variable exists, otherwise `false`.
     */
    func stateExisted(_ stateKey: GameStateKey) -> Bool {
        return states.first { $0.key == stateKey } != nil
    }
}
