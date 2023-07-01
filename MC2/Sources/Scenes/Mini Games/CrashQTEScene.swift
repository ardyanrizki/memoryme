//
//  CrashQTEScene.swift
//  MC2
//
//  Created /Users/clarabellalius/Desktop/Mini Challenge 2/memoryme-ada23/MC2/Sources/Scenes/Mini Games/RadioScene.swiftby Clarabella Lius on 01/07/23.
//

import SpriteKit
import GameplayKit
 
class CrashQTEScene: SKScene{
    
    var rectangle: SKSpriteNode!
    var swipeArrow: SKSpriteNode!
    var initialArrowPosition: CGPoint = .zero
    var isDraggingArrow = false

    
    override func didMove(to view: SKView) {
        rectangle = self.childNode(withName: "rectangle") as? SKSpriteNode
        swipeArrow = self.childNode(withName: "swipe-arrow") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
              let touchLocation = touch.location(in: self)

        if swipeArrow.contains(touchLocation) {
            initialArrowPosition = swipeArrow.position
            isDraggingArrow = true
            print("drag arrow")
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
            print("swipe arrow position: \(swipeArrow.position.x)")
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDraggingArrow = false
        let minX = rectangle.frame.minX
        let maxX = rectangle.frame.maxX
        let value = (swipeArrow.position.x - minX) / (maxX - minX)
                
    }
    

    
    
}
