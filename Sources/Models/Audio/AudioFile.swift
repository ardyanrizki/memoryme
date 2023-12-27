//
//  AudioFile.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 27/12/23.
//

import Foundation

/// Enumeration representing different audio files with their identifiers.
enum AudioFile: String, CaseIterable {
    // Background Music (BGM)
    case ambience = "ambience.mp3"
    case officeSnapshotsBGM = "cutscene-office.mp3"
    case barSnapshotsBGM = "cutscene-bar.mp3"
    case bedroomSnapshotsBGM = "cutscene-bedroom.mp3"
    
    // Sound Effects (SFX)
    case radioStatic = "radio-static.mp3"
    case truckHorn = "truck-horn.mp3"
    case footSteps = "foot-steps.mp3"
    case click = "keyboard-click.mp3"
    case door = "door.mp3"
    case phone = "phone.mp3"
    case burn = "burn.mp3"
    case lighter = "lighter.mp3"
}
