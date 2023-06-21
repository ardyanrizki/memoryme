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
