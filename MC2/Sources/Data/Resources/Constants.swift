//
//  Constants.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import Foundation

struct Constants {
    // Configs
    static let fontName = "Scribble-Regular"
    
    // Game infos
    static let gameTitle = "Me...Mory...Me"
    static let mainCharacterName = "Mory"
    
    // Game scenes
    static let testScene = "TestScene"
    static let titleScene = "TitleScene"
    static let mainRoomScene = "MainRoomScene"
    static let officeRoomScene = "OfficeRoomScene"
    static let bedroomScene = "BedroomScene"
    static let barScene = "BarScene"
    static let hospitalScene = "HospitalScene"
    
    // Default node names
    static let background = "background"
    
    // Action keys
    static let walkingAction = "walking"
    static let idleAction = "idle"
}

extension String {
    static let emptyString = ""
    
    // Error text
    static let initCoderNotImplemented = "init(coder:) has not been implemented"
    static let errorNodeNotFound = "error: node not found"
    static let errorTextureNotFound = "error: texture not found"
    static let errorPhysicsBodyNotFound = "error: physics body not found"
}
