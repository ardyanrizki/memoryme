//
//  AnimationComponent.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

struct Animation {
    let frames: [AnimationState: [SKTexture]]
}

class AnimationComponent: GKComponent {
    let entityNode: SKNode
    let frames: [AnimationState: [SKTexture]]
    
    init(entityNode: SKNode, frames: [AnimationState: [SKTexture]]) {
        self.entityNode = entityNode
        self.frames = frames
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation(state: AnimationState, timePerFrame: TimeInterval = 0.2) {
        if !entityNode.hasActions() {
            guard let stateFrames = frames[state] else { return }
            let animationAction = SKAction.animate(with: stateFrames, timePerFrame: timePerFrame)
            let repeatAction = SKAction.repeatForever(animationAction)
            entityNode.run(repeatAction, withKey: "w")
        }
    }
    
    func stopAnimation() {
        guard let characterNode = entity?.component(ofType: CharacterVisualComponent.self)?.characterNode else {
            return
        }
        
        // Remove any running actions from the character node
        characterNode.removeAllActions()
        guard let texture = frames[.idle]?.first else { return }
        characterNode.texture = texture
    }
}
