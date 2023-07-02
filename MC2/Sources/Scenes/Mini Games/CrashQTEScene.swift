//
//  CrashQTEScene.swift
//  MC2
//
//  Created /Users/clarabellalius/Desktop/Mini Challenge 2/memoryme-ada23/MC2/Sources/Scenes/Mini Games/RadioScene.swiftby Clarabella Lius on 01/07/23.
//

import SpriteKit
import GameplayKit
 
class CrashQTEScene: PlayableScene{
    
    var rectangle: SKSpriteNode!
    var swipeArrow: SKSpriteNode!
    var initialArrowPosition: CGPoint = .zero
    var isDraggingArrow = false
    
    var timerNode: SKLabelNode!
    
    var counter = 0
    var counterTimer = Timer()
    var counterStartValue = 5
    
    var withinTimeFrame = false
    
    override func didMove(to view: SKView) {
        rectangle = self.childNode(withName: "rectangle") as? SKSpriteNode
        swipeArrow = self.childNode(withName: "swipe-arrow") as? SKSpriteNode
        timerNode = self.childNode(withName: "timerNode") as? SKLabelNode
        timerNode.fontName = "Scribble-Regular"
        timerNode.position = CGPoint(x: 273, y: -407.9)
        
        counter = counterStartValue
        startCounter()
    }
    
    func startCounter(){
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter(){ //kalau udah sampe 0
        counter -= 1
        timerNode.text = "\(counter)"
        
        if counter == 0{
            counterTimer.invalidate()
           //move to scene fail
        }
    }
    
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
        let value = (swipeArrow.position.x - minX) / (maxX - minX)
    }
    
}
