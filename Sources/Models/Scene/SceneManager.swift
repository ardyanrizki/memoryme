//
//  SceneManager.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 26/12/23.
//

import SpriteKit

/// A protocol defining methods to present various scenes in the game.
protocol SceneManager: AnyObject {
    /// Presents the title screen or main menu.
    func presentTitleScreen()

    /// Presents the ending screen or game over screen.
    func presentEndingScreen()
    
    /// Presents the main room scene.
    ///
    /// - Parameters:
    ///   - playerPosition: The initial position of the character in the main room.
    func presentHall(playerPosition: CharacterPosition)

    /// Presents the office room scene.
    ///
    /// - Parameters:
    ///   - playerPosition: The initial position of the character in the office.
    ///   - transition: Optional transition for scene presentation.
    func presentOffice(playerPosition: CharacterPosition, transition: SKTransition?)

    /// Presents the bedroom scene.
    ///
    /// - Parameters:
    ///   - playerPosition: The initial position of the character in the bedroom.
    func presentBedroom(playerPosition: CharacterPosition)

    /// Presents the bar scene.
    ///
    /// - Parameters:
    ///   - playerPosition: The initial position of the character in the bar.
    ///   - transition: Optional transition for scene presentation.
    func presentBar(playerPosition: CharacterPosition, transition: SKTransition?)

    /// Presents the hospital scene.
    func presentHospital()
    
    /// Presents the input pin mini-game scene.
    func presentInputPinMiniGame()

    /// Presents the matching numbers mini-game scene.
    func presentMatchingNumbersMiniGame()

    /// Presents the photo album mini-game scene.
    func presentPhotoAlbumMiniGame()

    /// Presents the second phase of the photo album mini-game scene.
    func presentPhotoAlbumSecondMiniGame()

    /// Presents the radio tuner mini-game scene.
    func presentRadioTunerMiniGame()

    /// Presents the crash quick time event (QTE) mini-game scene.
    func presentCrashQTEMiniGame()
    
    /// Presents the working snapshots scene.
    func presentWorkingSnapshots()

    /// Presents the photo album snapshots scene.
    func presentPhotoAlbumSnapshots()

    /// Presents the stranger snapshots scene.
    func presentStrangerSnapshots()
}
