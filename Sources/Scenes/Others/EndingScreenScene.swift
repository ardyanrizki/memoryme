//
//  EndingScreenScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 26/12/23.
//

import SpriteKit

class EndingScreenScene: GameScene {
    
    var endingLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupLabel()
        
        Task {
            let sleepDuration: UInt64 = 2 * 1_000_000_000
            
            try? await Task.sleep(nanoseconds: sleepDuration)
            updateEndingLabel(
                text: isNotAnyonePresent ? "...memories are etched like timeless engravings." : "The best thing to hold onto in life is each other.",
                fontSize: 40
            )
            await fadeInOut(node: endingLabel, duration: 3)
            
            try? await Task.sleep(nanoseconds: sleepDuration)
            updateEndingLabel(text: "Story by Road to Mythic", fontSize: 40)
            await fadeInOut(node: endingLabel)
            
            try? await Task.sleep(nanoseconds: sleepDuration)
            updateEndingLabel(text: "Designed & Developed by Road to Mythic", fontSize: 40)
            await fadeInOut(node: endingLabel)
            
            try? await Task.sleep(nanoseconds: sleepDuration)
            updateEndingLabel(text: "The End", fontSize: 80)
            await fadeInOut(node: endingLabel, duration: 4)
            
            try? await Task.sleep(nanoseconds: sleepDuration)
            sceneManager?.presentTitleScreen()
            audioManager?.play(audioFile: .ambience, type: .background)
        }
    }
    
    func setupLabel() {
        endingLabel = SKLabelNode(fontNamed: Constants.fontName)
        endingLabel.text = "The End"
        endingLabel.name = "ending-label"
        endingLabel.fontSize = 80
        endingLabel.fontColor = .black
        endingLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        endingLabel.zPosition = 10
        endingLabel.alpha = 0
        addChild(endingLabel)
    }
    
    func updateEndingLabel(text: String, fontSize: CGFloat) {
        endingLabel.text = text
        endingLabel.fontSize = fontSize
    }
    
    func fadeInOut(node: SKNode, duration: TimeInterval = 1.5) async {
        let fadeInAction = SKAction.fadeIn(withDuration: duration)
        let waitAction = SKAction.wait(forDuration: 4)
        let fadeOutAction = SKAction.fadeOut(withDuration: duration)
        await node.run(SKAction.sequence([
            fadeInAction,
            waitAction,
            fadeOutAction
        ]))
    }
    
    var isNotAnyonePresent: Bool {
        stateManager?.getState(key: .momsCallAccepted) != .boolValue(true) &&
        stateManager?.getState(key: .friendsPhotosKept) != .boolValue(true) &&
        stateManager?.getState(key: .strangerSaved) != .boolValue(true)
    }
}
