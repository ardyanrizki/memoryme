//
//  TextureResources.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

typealias TextureName = String

extension TextureName {
    func getTexture() -> SKTexture {
        SKTexture(imageNamed: self)
    }
}

typealias TextureAtlasName = String

extension TextureAtlasName {
    var textureAtlas: SKTextureAtlas {
        SKTextureAtlas(named: self)
    }
    
    var textures: [SKTexture] {
        let atlas = textureAtlas
        let sortedTextureNames =  atlas.textureNames.sorted(using: .localizedStandard)
            .map { atlas.textureNamed($0) }
        return sortedTextureNames
    }
}

struct TextureResources {
    
    // MARK: - Generic
    static let backButton: TextureName = "back-button"
    static let incorrectPinText: TextureName = "incorrect-pin-text"
    
    // MARK: - Characters
    // Character's statics
    static let mainCharacter: TextureName = "mory_static"
    static let bartenderCharacter: TextureName = "bartender_static"
    static let colorfulBartenderCharacter: TextureName = "colorful_bartender_static"
    static let dadCharacter: TextureName = "dad_static"
    static let momCharacter: TextureName = "mom_static"
    static let friend1Character: TextureName = "friend1_static"
    static let friend2Character: TextureName = "friend2_static"
    
    // Character's atlas name
    static let bubbleAtlasStatic: TextureAtlasName = "bubble_atlas"
    static let mainCharacterAtlasIdle: TextureAtlasName = "mory_idle_atlas"
    static let mainCharacterAtlasWalk: TextureAtlasName = "mory_walk_atlas"
    static let mainCharacterAtlasLay: TextureAtlasName = "mory_lay_atlas"
    static let mainCharacterAtlasRest: TextureAtlasName = "mory_rest_atlas"
    static let mainCharacterAtlasSleep: TextureAtlasName = "mory_sleep_atlas"
    static let bartenderCharacterAtlasIdle: TextureAtlasName = "bartender_idle_atlas"
    static let bartenderCharacterAtlasWalk: TextureAtlasName = "bartender_walk_atlas"
    static let colorfulBartenderCharacterAtlasIdle: TextureAtlasName = "colorful_bartender_idle_atlas"
    static let colorfulBartenderCharacterAtlasWalk: TextureAtlasName = "colorful_bartender_walk_atlas"
    static let momCharacterAtlasIdle: TextureAtlasName = "mom_idle_atlas"
    static let momCharacterAtlasWalk: TextureAtlasName = "mom_walk_atlas"
    static let dadCharacterAtlasIdle: TextureAtlasName = "dad_idle_atlas"
    static let dadCharacterAtlasWalk: TextureAtlasName = "dad_walk_atlas"
    static let friend1CharacterAtlasIdle: TextureAtlasName = "friend1_idle_atlas"
    static let friend1CharacterAtlasWalk: TextureAtlasName = "friend1_walk_atlas"
    static let friend2CharacterAtlasIdle: TextureAtlasName = "friend2_idle_atlas"
    static let friend2CharacterAtlasWalk: TextureAtlasName = "friend2_walk_atlas"
    
    // MARK: - Shared items
    static let sideDoor: TextureName = "side-door_static"
    
    // MARK:  - Rooms's Items
    // Items in MainRoom
    static let vaseRipe: TextureName = "vase_ripe"
    static let vaseBudding: TextureName = "vase_budding"
    static let vasePartialBlossom: TextureName = "vase_partial-blossom"
    static let vaseFullBlossom: TextureName = "vase_full-blossom"
    static let laptop: TextureName = "laptop_static"
    static let lowerDoor: TextureName = "lower-door_static"
    static let mainWindowClosed: TextureName = "main-window_closed"
    static let mainWindowOpened: TextureName = "main-window_opened"
    static let broom: TextureName = "broom"
    static let mainDeskNormal: TextureName = "main-desk_normal"
    static let mainDeskClosed: TextureName = "main-desk_closed"
    static let mainDeskOpened: TextureName = "main-desk_opened"
    static let radioTable = "radio-table"
    
    // Items in Office
    static let bookshelf: TextureName = "bookshelf_static"
    static let bossDesk: TextureName = "boss-desk_static"
    static let officeChairFlipped: TextureName = "office-chair-flipped_static"
    static let officeChair: TextureName = "office-chair_static"
    static let officeDeskBehind: TextureName = "office-desk-behind_static"
    static let officeDeskFront: TextureName = "office-desk-front_static"
    static let whiteboard: TextureName = "whiteboard_static"
    static let macbook: TextureName = "macbook"
    static let photoframe: TextureName = "photoframe"
    static let familyPhotoFrame: TextureName = "family-photo-frame"
    
    // Items in Bedroom
    // - Messy
    static let bedMessy: TextureName = "bed_messy"
    static let booksMessy: TextureName = "books_messy"
    static let bookshelfMessy: TextureName = "bookshelf_messy"
    static let chairMessy: TextureName = "chair_messy"
    static let clothesMessy: TextureName = "clothes_messy"
    static let computerMessy: TextureName = "computer_messy"
    static let curtainMessy: TextureName = "curtain_messy"
    static let deskMessy: TextureName = "desk_messy"
    static let pillowMessy: TextureName = "pillow_messy"
    static let wardrobeMessy: TextureName = "wardrobe_messy"
    static let windowMessy: TextureName = "window_messy"
    // - Tidy
    static let bedTidy: TextureName = "bed_tidy"
    static let bookshelfTidy: TextureName = "bookshelf_tidy"
    static let deskTidy: TextureName = "desk_tidy"
    static let wardrobeTidy: TextureName = "wardrobe_tidy"
    static let windowTidy: TextureName = "window_tidy"
    // Others
    static let photoAlbum: TextureName = "photo-album"
    
    // Items in Bar
    static let barIslandLeft: TextureName = "bar-island-left_static"
    static let barIslandRight: TextureName = "bar-island-right_static"
    static let radioBar: TextureName = "radio_normal"
    static let stool: TextureName = "stool_static"
    static let tableAndChairs: TextureName = "table-and-chairs_static"
    static let upperDoor: TextureName = "upper-door_normal"
    static let upperDoorSketchy: TextureName = "upper-door_sketchy"
    static let upperDoorVague: TextureName = "upper-door_vague"
    static let upperDoorClear: TextureName = "upper-door_clear"
    static let wallPot: TextureName = "wall-pot_static"
    
    // Items in Hospital
    static let leftSofa = "sofa_left_static"
    static let rightSofa = "sofa_right_static"
    static let trash = "trash_static"
    
    // MARK: - Rooms's backgrounds
    static let mainRoom: TextureName = "main-room"
    static let officeRoom: TextureName = "office-room"
    static let bedroom: TextureName = "bedroom"
    static let bar: TextureName = "bar"
    static let hospital: TextureName = "hospital"
    
    // MARK: Bubbles
    static let bubble1: TextureName = "bubble_1"
    static let bubble2: TextureName = "bubble_2"
    static let bubble3: TextureName = "bubble_3"
    
    // MARK: Title
    static let title: TextureName = "title"
    static let startButton: TextureName = "start-button"
    
    // MARK: Polaroid
    static let polaroidBirthday: TextureName = "polaroid-birthday"
    static let polaroidBoyfriend: TextureName = "polaroid-boyfriend"
    static let polaroidBracelet: TextureName = "polaroid-bracelet"
    static let polaroidChocolate: TextureName = "polaroid-chocolate"
    static let polaroidFight: TextureName = "polaroid-fight"
    static let polaroidFriend: TextureName = "polaroid-friend"
    static let polaroidHappy: TextureName = "polaroid-happy"
    
    // MARK: Mini game - Laptop
    static let macbookCloseUp: TextureName = "macbook_close-up"
    static let macbookLoginScreen: TextureName = "macbook-login-screen"
    static let macbookVerificationScreen: TextureName = "macbook-verification-screen"
    static let macbookEmailScreen: TextureName = "macbook-email-screen"
}
