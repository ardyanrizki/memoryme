//
//  PositionNode.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import SpriteKit

class PositionNode: SKNode {
    var identifier: PositionIdentifier
    
    init(with identifier: PositionIdentifier) {
        self.identifier = identifier
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
