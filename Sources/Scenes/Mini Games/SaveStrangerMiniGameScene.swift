//
//  SaveStrangerMiniGameScene.swift
//  Memoryme
//
//  Created by Clarabella Lius on 01/07/23.
//

import SpriteKit
import GameplayKit

/// A scene representing a Quick Time Event (QTE) for avoiding a crash.
class SaveStrangerMiniGameScene: GameScene {
    
    // MARK: - Properties
    
    var rectangle: SKSpriteNode!
    var swipeArrow: SKSpriteNode!
    var goalNode: SKSpriteNode!
    var initialArrowPosition: CGPoint = .zero
    var isDraggingArrow = false
    
    var timerNode: SKLabelNode!
    
    var counter = 0
    var counterTimer = Timer()
    var counterStartValue = 5
    
    // MARK: - Scene Lifecycle
    
    override func update(_ currentTime: TimeInterval) {
        detectGoalIntersect()
    }
    
    override func didMove(to view: SKView) {
        setupSceneElements()
        audioManager?.play(audioFile: .truckHorn, type: .soundEffect, playingTimes: 2)
        counter = counterStartValue
        startCounter()
    }
    
    // MARK: - QTE Logic
    
    func detectGoalIntersect() {
        if swipeArrow.intersects(goalNode) {
            counterTimer.invalidate()
            stateManager?.setState(key: .strangerSaved, value: .boolValue(true))
            sceneManager?.presentStrangerSnapshots()
        }
    }
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter() {
        counter -= 1
        timerNode.text = "\(counter)"
        
        if counter == 0 {
            counterTimer.invalidate()
            stateManager?.setState(key: .strangerSaved, value: .boolValue(false))
            sceneManager?.presentStrangerSnapshots()
        }
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        if swipeArrow.contains(touchLocation) {
            initialArrowPosition = swipeArrow.position
            isDraggingArrow = true
        }
    }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if isDraggingArrow {
            let minX = rectangle.frame.minX + 75
            let maxX = rectangle.frame.maxX - 75
            let newPosition = CGPoint(x: max(min(touchLocation.x, maxX), minX), y: swipeArrow.position.y)
            swipeArrow.position = newPosition
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDraggingArrow = false
        let minX = rectangle.frame.minX
        let maxX = rectangle.frame.maxX
        let _ = (swipeArrow.position.x - minX) / (maxX - minX)
    }
    
    // MARK: - Helper Methods
    
    /// Sets up elements specific to the QTE scene.
    func setupSceneElements() {
        rectangle = self.childNode(withName: "rectangle") as? SKSpriteNode
        swipeArrow = self.childNode(withName: "swipe-arrow") as? SKSpriteNode
        goalNode = self.childNode(withName: "goal-node") as? SKSpriteNode
        timerNode = self.childNode(withName: "timerNode") as? SKLabelNode
        timerNode.fontName = "Scribble-Regular"
        timerNode.position = CGPoint(x: 288, y: -426.338)
    }
}
