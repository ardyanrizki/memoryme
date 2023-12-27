//
//  CharacterAnimationState.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import Foundation

/**
 Represents the possible animation states for a character.
 */
enum CharacterAnimationState: String {
    /// Character is in a static animation state.
    case `static`
    
    /// Character is in an idle animation state.
    case idle
    
    /// Character is in a walking animation state.
    case walk
    
    /// Character is in a sitting animation state.
    case sit
    
    /// Character is in a lying down animation state.
    case lay
    
    /// Character is in a sleeping animation state.
    case sleep
}
