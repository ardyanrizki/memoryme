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
    static let mainCharacter: TextureName = "Mory_Static"
    static let dadCharacter: TextureName = "Dad_Static"
    static let momCharacter: TextureName = "Mom_Static"
    static let bossCharacter: TextureName = "Boss_Static"
    static let friendCharacter: TextureName = "Friend_Static"
    static let bartenderCharacter: TextureName = "Bartender_Static"
    
    // MARK: Characters's atlas name
    static let mainCharacterAtlasWalk: TextureAtlasName = "Mory_Walk"
    static let mainCharacterAtlasLay: TextureAtlasName = "Mory_Lay"
    static let dadCharacterAtlasWalk: TextureAtlasName = "Dad_Walk"
    static let momCharacterAtlasWalk: TextureAtlasName = "Mom_Walk"
    static let bossCharacterAtlasWalk: TextureAtlasName = "Boss_Walk"
    static let friendCharacterAtlasWalk: TextureAtlasName = "Friend_Walk"
    static let bartenderCharacterAtlasWalk: TextureAtlasName = "Bartender_Walk"
    
    // MARK: Items
    static let vase: TextureName = "Vase_Static"
    static let laptop: TextureName = "Laptop_Static"
    static let radio: TextureName = "Radio_Static"
    
    // MARK: Rooms
    static let mainRoom: TextureName = "MainRoom"
    static let officeRoom: TextureName = "OfficeRoom"
    static let bedroom: TextureName = "Bedroom"
    static let bar: TextureName = "Bar"
    static let hospital: TextureName = "Hospital"
    
    // MARK: Title
    static let title: TextureName = "Title"
    static let startButton: TextureName = "StartButton"
}
