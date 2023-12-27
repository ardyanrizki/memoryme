//
//  CharacterVisualComponent.swift
//  Memoryme
//
//  Created by Ivan on 18/06/23.
//

import Foundation
import SpriteKit
import GameplayKit

/// `CharacterVisualComponent` is responsible for managing the visual representation of a character.
class CharacterVisualComponent: GKComponent {
    
    /// The textures for different animation states.
    let textures: [CharacterAnimationState: [SKTexture]]
    
    /// The current animation state of the character.
    var state: CharacterAnimationState = .idle
    
    /// The render component associated with the character.
    let renderComponent: RenderComponent
    
    /// Initializes a character visual component with textures and a render component.
    /// - Parameters:
    ///   - textures: The textures for different animation states.
    ///   - renderComponent: The render component associated with the character.
    init(textures: [CharacterAnimationState: [SKTexture]], renderComponent: RenderComponent) {
        self.renderComponent = renderComponent
        self.textures = textures
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
}

