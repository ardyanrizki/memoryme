//
//  Constants.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import Foundation

struct Constants {
    // Configs
    static let fontName = "Scribble-Regular"
    
    /// The default Z-position for overlays.
    static let defaultOverlayZPosition: CGFloat = 99.0
    
    // Game infos
    static let gameTitle = "Me...Mory...Me"
    static let mainCharacterName = "Mory"
    static let bartenderName = "Bartender"
    static let momName = "Mom"
    static let dadName = "Dad"
    static let friend1Name = "Friend 1"
    static let friend2Name = "Friend 2"
    
    // Game scenes
    static let titleScreenScene = "TitleScreenScene"
    static let endingScreenScene = "EndingScreenScene"
    
    static let hallScene = "HallScene"
    static let officeScene = "OfficeScene"
    static let bedroomMessyScene = "BedroomMessyScene"
    static let bedroomTidyScene = "BedroomTidyScene"
    static let barScene = "BarScene"
    static let hospitalScene = "HospitalScene"
    
    static let inputPinMiniGameScene = "InputPinMiniGameScene"
    static let matchingNumberMiniGameScene = "MatchingNumberMiniGameScene"
    static let photoAlbumMiniGameFirstScene = "PhotoAlbumMiniGameFirstScene"
    static let photoAlbumMiniGameSecondScene = "PhotoAlbumMiniGameSecondScene"
    static let radioTunerMiniGameScene = "RadioTunerMiniGameScene"
    static let saveStrangerMiniGameScene = "SaveStrangerMiniGameScene"
    
    // Snapshots
    static let officeSnapshotsScene = "OfficeSnapshotsScene"
    static let bedroomSnapshotsScene = "PhotoAlbumSnapshotsScene"
    static let saveStrangerSnapshotScene = "SaveStrangerSnapshotScene"
    
    // Snapshots: Office
    static let acceptNode = "acceptNode"
    static let declineNode = "declineNode"
    
    // Snapshots: Bedroom
    static let secondMemoryA = "memory-2a"
    static let secondMemoryB = "memory-2b"
    static let secondMemoryC = "memory-2c"
    static let secondMemoryD = "memory-2d"
    static let keepButton = "keep-button"
    static let burnButton = "burn-button"
    static let tapLabel = "tap-label"
    static let tapToContinue = "Tap to continue"
    
    
    // Photo album game
    static let backButtonName = "back-button"
    static let targetPositionNodes = "targetPositionNodes"
    static let polaroidNodes = "polaroidNodes"
    
    // Default node names
    static let background = "background"
    static let overlayWrapper = "overlayWrapper"
}

