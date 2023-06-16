//
//  Player.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class Player: GKEntity {
    /// The size to use for the `Player`s animation textures.
    static var textureSize = CGSize(width: 120.0, height: 120.0)
    
    override init() {
        super.init()
        
        addingComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingComponents() {
        
    }
}
