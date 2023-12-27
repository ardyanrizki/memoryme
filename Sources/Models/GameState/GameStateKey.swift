//
//  GameStateKey.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import Foundation

/**
 Represents keys used for state management.
 */
enum GameStateKey: String {
    /// Key for representing the scene activity state.
    case sceneActivity
    
    /// Key for representing whether a call from mom has been accepted.
    case momsCallAccepted
    
    /// Key for representing whether photos of friends are kept.
    case friendsPhotosKept
    
    /// Key for representing whether a stranger has been saved.
    case strangerSaved
}

