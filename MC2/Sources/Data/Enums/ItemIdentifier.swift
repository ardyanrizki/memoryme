//
//  ItemIdentifier.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 25/06/23.
//

import SpriteKit

enum ItemIdentifier: String, CaseIterable {
    // MARK: Bubbles Item
    case bubble = "bubble"
    
    // MARK: Items in Office
    case topDoor = "topDoor"
    case lowerDoor = "lowerDoor"
    case sideDoor = "sideDoor"
    
    // MARK: Items in Office
    case macbook = "macbook"
    case photoframe = "photoframe"
    case bookshelfOffice = "bookshelfOffice"
    case whiteboard = "whiteboard"
    case officeDeskFront = "officeDeskFront"
    case officeDeskBehind = "officeDeskBehind"
    case bossDesk = "bossDesk"
    case officeChair = "officeChair"
    case officeChairFlipped = "officeChairFlipped"
    
    // MARK: Items in MainRoom
    case vase = "vase"
    
    // MARK: Items in Bedroom
    case bed = "bed"
    case bedTidy = "bedTidy"
    case book = "book"
    case bookshelf = "bookshelf"
    case bookshelfTidy = "bookshelfTidy"
    case chair = "chair"
    case clothes = "clothes"
    case curtain = "curtain"
    case computer = "computer"
    case desk = "desk"
    case deskTidy = "deskTidy"
    case photoAlbum = "photoAlbum"
    case pillow = "pillow"
    case wardrobe = "wardrobe"
    case wardrobeTidy = "wardrobeTidy"
    case window = "window"
    case windowTidy = "windowTidy"
    
    //MARK: Items in Bar
    case barIslandLeft = "barIslandLeft"
    case barIslandRight = "barIslandRight"
    case radioBar = "radioBar"
    case stool = "stool"
    case stool2 = "stool2"
    case stool3 = "stool3"
    case tableAndChairs = "tableAndChairs"
    case tableAndChairs2 = "tableAndChairs3"
    case tableAndChairs3 = "tableAndChairs2"
    case upperDoor = "upperDoor"
    case wallPot = "wallPot"
    
    func getAllNodes(from scene: SKScene, zPosition: CGFloat = 1) -> [ItemNode] {
        var nodes = [ItemNode]()
        scene.children.forEach { node in
            guard let nodeRawName = node.name, nodeRawName.contains(self.rawValue) else { return }
            let splittedStr = nodeRawName.splitIdentifer()
            guard let nodeName = splittedStr.first(where: { $0 == self.rawValue }) else { return }
            let textureType = splittedStr.compactMap { str in
                ItemTextureType.allCases.first(where: { $0.rawValue == str })
            }.first
            guard let node = scene.childNode(withName: nodeRawName) as? ItemNode else { return }
            node.identifier = self
            node.name = nodeName
            node.textures = getTextures()
            node.textureType = textureType ?? getTextures().first?.key
            if let texture = getTextures()[node.textureType ?? getTextures().first?.key ?? .normal] {
                node.run(SKAction.setTexture(texture, resize: true))
            }
            node.zPosition = zPosition
            nodes.append(node)
        }
        return nodes
    }
    
    func createNode(in scene: SKScene, withTextureType textureType: ItemTextureType?, zPosition: CGFloat = 1) -> ItemNode? {
        let node = scene.childNode(withName: self.rawValue) as? ItemNode
        node?.identifier = self
        node?.textures = getTextures()
        node?.textureType = textureType ?? getTextures().first?.key
        node?.name = self.rawValue
        if let texture = node?.textures?[node?.textureType ?? .normal] {
            node?.run(SKAction.setTexture(texture, resize: true))
        }
        node?.zPosition = zPosition
        return node
    }
    
    /**
     Returns textures for this item's identifier.
     - WARNING: First texture always run for the first time as a default texture in `ItemNode`.
     */
    func getTextures() -> [ItemTextureType: SKTexture] {
        var textures = [ItemTextureType: SKTexture]()
        // TODO: Add item textures
        switch self {
        case .bubble:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.bubble1)
            ]
        case .macbook:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.macbook)
            ]
        case .photoframe:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.photoframe)
            ]
        case .bookshelfOffice:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.bookshelf)
            ]
        case .whiteboard:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.whiteboard)
            ]
        case .officeDeskFront:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.officeDeskFront)
            ]
        case .officeDeskBehind:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.officeDeskBehind)
            ]
        case .officeChairFlipped:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.officeChairFlipped)
            ]
        case .bossDesk:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.bossDesk)
            ]
        case .officeChair:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.officeChair)
            ]
        case .vase:
            textures = [
                .ripe: SKTexture(imageNamed: TextureResources.vaseRipe),
                .budding: SKTexture(imageNamed: TextureResources.vaseBudding),
                .partialBlossom: SKTexture(imageNamed: TextureResources.vasePartialBlossom),
                .fullBlossom: SKTexture(imageNamed: TextureResources.vaseFullBlossom)
            ]
        case .bed:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.bedMessy)
            ]
        case .bedTidy:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.bedTidy)
            ]
        case .book:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.booksMessy)
            ]
        case .bookshelf:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.bookshelfMessy)
            ]
        case .bookshelfTidy:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.bookshelfTidy)
            ]
        case .chair:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.chairMessy)
            ]
        case .clothes:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.clothesMessy)
            ]
        case .curtain:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.curtainMessy)
            ]
        case .computer:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.computerMessy)
            ]
        case .desk:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.deskMessy)
            ]
        case .deskTidy:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.deskTidy)
            ]
        case .photoAlbum:
            textures = [
                .normal: SKTexture(imageNamed: TextureResources.photoAlbum)
            ]
        case .pillow:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.pillowMessy)
            ]
        case .wardrobe:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.wardrobeMessy)
            ]
        case .wardrobeTidy:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.wardrobeTidy)
            ]
        case .window:
            textures = [
                .messy: SKTexture(imageNamed: TextureResources.windowMessy)
            ]
        case .windowTidy:
            textures = [
                .tidy: SKTexture(imageNamed: TextureResources.windowTidy)
            ]
        case .barIslandLeft:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.barIslandLeft)
            ]
        case .barIslandRight:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.barIslandRight)
            ]
        case .radioBar:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.radioBar)
            ]
        case .stool:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.stool)
            ]
        case .stool2:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.stool)
            ]
        case .stool3:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.stool)
            ]
        case .tableAndChairs:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.tableAndChairs)
            ]
        case .tableAndChairs2:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.tableAndChairs)
            ]
        case .tableAndChairs3:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.tableAndChairs)
            ]
        case .upperDoor:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.upperDoor)
            ]
        case .wallPot:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.wallPot)
            ]
        case .topDoor:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.upperDoor),
                .sketchy : SKTexture(imageNamed: TextureResources.upperDoorSketchy),
                .vague : SKTexture(imageNamed: TextureResources.upperDoorVague),
                .clear : SKTexture(imageNamed: TextureResources.upperDoorClear),
            ]
        case .lowerDoor:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.lowerDoor)
            ]
        case .sideDoor:
            textures = [
                .normal : SKTexture(imageNamed: TextureResources.sideDoor)
            ]
        }
        return textures
    }
    
    func getSize() -> CGSize? {
        guard let size = getTextures().first?.value.size() else { return nil }
        switch self {
        case .bubble:
            return nil
        case .macbook:
            return CGSize(width: size.width, height: size.height)
        case .photoframe:
            return CGSize(width: size.width, height: size.height)
        case .bookshelfOffice:
            return nil
        case .whiteboard:
            return nil
        case .officeDeskFront:
            return nil
        case .officeDeskBehind:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .bossDesk:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .officeChair:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .officeChairFlipped:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .vase:
            return nil
        case .bed:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .bedTidy:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .book:
            return nil
        case .bookshelf:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .bookshelfTidy:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .chair:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .clothes:
            return nil
        case .curtain:
            return nil
        case .computer:
            return nil
        case .desk:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .deskTidy:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .photoAlbum:
            return nil
        case .pillow:
            return nil
        case .wardrobe:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .wardrobeTidy:
            return CGSize(width: size.width, height: size.height * 0.8)
        case .window:
            return nil
        case .windowTidy:
            return nil
        case .barIslandLeft:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .barIslandRight:
            return CGSize(width: size.width, height: size.height * 0.9)
        case .radioBar:
            return nil
        case .stool:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .stool2:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .stool3:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .tableAndChairs:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .tableAndChairs2:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .tableAndChairs3:
            return CGSize(width: size.width, height: size.height * 0.6)
        case .upperDoor:
            return CGSize(width: size.width, height: size.height)
        case .wallPot:
            return nil
        case .topDoor:
            return nil
        case .lowerDoor:
            return nil
        case .sideDoor:
            return nil
        }
    }
}
