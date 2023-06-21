//
//  MainPlayerComponent.swift
//  MC2
//
//  Created by Ivan on 18/06/23.
//

import Foundation
import GameplayKit

class MainPlayerComponent: GKComponent{
    var playerNode: SKNode
    
    init(playerNode: SKNode) {
        self.playerNode = playerNode
        self.playerNode.name = CharacterType.mainCharacter.rawValue
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
