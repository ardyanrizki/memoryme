//
//  TextureResources.swift
//  MC2
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
    func getTextureAtlas() -> SKTextureAtlas {
        SKTextureAtlas(named: self)
    }
    
    func getAllTexturesFromAtlas() -> [SKTexture] {
        let atlas = getTextureAtlas()
        return atlas.textureNames.sorted().map { atlas.textureNamed($0) }
    }
}

struct TextureResources {
    
    // MARK: Characters
    static let mainCharacter: TextureName = "mory_static"
    static let dadCharacter: TextureName = "dad_static"
    static let momCharacter: TextureName = "mom_static"
    static let bossCharacter: TextureName = "boss_static"
    static let friendCharacter: TextureName = "friend_static"
    static let bartenderCharacter: TextureName = "bartender_static"
    
    // MARK: Characters's atlas name
    static let mainCharacterAtlasIdle: TextureAtlasName = "mory_idle"
    static let mainCharacterAtlasWalk: TextureAtlasName = "mory_walk"
    static let mainCharacterAtlas_lay: TextureAtlasName = "mory_lay"
    static let dadCharacterAtlasWalk: TextureAtlasName = "dad_walk"
    static let momCharacterAtlasWalk: TextureAtlasName = "mom_walk"
    static let bossCharacterAtlasWalk: TextureAtlasName = "boss_walk"
    static let friendCharacterAtlasWalk: TextureAtlasName = "friend_walk"
    static let bartenderCharacterAtlasWalk: TextureAtlasName = "bartender_walk"
    
    // MARK: Items in office
    static let vase: TextureName = "vase_static"
    static let laptop: TextureName = "laptop_static"
    static let radio: TextureName = "radio_static"
    
    // MARK: Items in bedroom
    static let bedMessy: TextureName = "bed_messy"
    static let bookMessy: TextureName = "book_messy"
    static let bookshelfMessy: TextureName = "bookshelf_messy"
    static let chairMessy: TextureName = "chair_messy"
    static let clothesMessy: TextureName = "clothes_messy"
    static let computerMessy: TextureName = "computer_messy"
    static let deskMessy: TextureName = "desk_messy"
    static let pillowMessy: TextureName = "pillow_messy"
    static let wardrobeMessy: TextureName = "wardrobe_messy"
    static let curtainMessy: TextureName = "curtain_messy"
    static let windowMessy: TextureName = "window_messy"
    
    static let bedTidy: TextureName = "bed_tidy"
    static let bookshelfTidy: TextureName = "bookshelf_tidy"
    static let deskTidy: TextureName = "desk_tidy"
    static let wardrobeTidy: TextureName = "wardrobe_tidy"
    static let windowTidy: TextureName = "window_tidy"
    
    static let photoAlbum: TextureName = "photo-album"
    
    // MARK: Rooms
    static let mainRoom: TextureName = "main-room"
    static let officeRoom: TextureName = "office-room"
    static let bedroom: TextureName = "bedroom"
    static let bar: TextureName = "bar"
    static let hospital: TextureName = "hospital"
    
    // MARK: Title
    static let title: TextureName = "title"
    static let startButton: TextureName = "start-button"
}
