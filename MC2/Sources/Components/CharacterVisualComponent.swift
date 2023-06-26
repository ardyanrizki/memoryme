//
//  CharacterVisualComponent.swift
//  MC2
//
//  Created by Ivan on 18/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

class CharacterVisualComponent: GKComponent {
    
    let textures: [AnimationState: [SKTexture]]
    var state: AnimationState = .idle
    
    let renderComponent: RenderComponent
    
    init(textures: [AnimationState: [SKTexture]], renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        self.textures = textures
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
}
