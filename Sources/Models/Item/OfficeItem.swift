//
//  OfficeItem.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

enum OfficeItem: String {
    case bookshelfOffice
    case bossDesk
    case macBook
    case officeChair
    case officeChairFlipped
    case officeDeskBehind
    case officeDeskFront
    case photoFrame
    case whiteboard
    
    private var props: ItemProps {
        switch self {
        case .bookshelfOffice:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.bookshelf)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .bossDesk:
            return .init(heightMultiplier: 0.8,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.bossDesk)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .macBook:
            return .init(heightMultiplier: 1,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.macbook)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .officeChair:
            return .init(widthMultiplier: 0.9,
                         heightMultiplier: 0.6,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.officeChair)],
                         makePhysicsBody: { node in makeEllipsePhysicsBody() })
        case .officeChairFlipped:
            return .init(widthMultiplier: 0.9,
                         heightMultiplier: 0.6,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.officeChairFlipped)],
                         makePhysicsBody: { node in makeEllipsePhysicsBody() })
        case .officeDeskBehind:
            return .init(heightMultiplier: 0.6,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.officeDeskBehind)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .officeDeskFront:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.officeDeskFront)],
                         makePhysicsBody: { node in
                let rect = CGRect(x: -(node.size.width / 2), y: 0 - (node.size.height / 2), width: node.size.width, height: node.size.height)
                return makeRoundedRectPhysicsBody(rect)
            })
        case .photoFrame:
            return .init(heightMultiplier: 1,
                         textures: [.normal: SKTexture(imageNamed: TextureResources.photoframe)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        case .whiteboard:
            return .init(textures: [.normal: SKTexture(imageNamed: TextureResources.whiteboard)],
                         makePhysicsBody: { node in makeRectPhysicsBody(node: node) })
        }
    }
}

extension OfficeItem: RenderableItem {
    
    var textures: [ItemTextureType : SKTexture] {
        props.textures
    }
    
    var size: CGSize? {
        props.size
    }
    
    var makePhysicsBody: (ItemNode) -> SKPhysicsBody?  {
        props.makePhysicsBody
    }
    
}
