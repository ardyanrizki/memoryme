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
    
    override func didMove(to view: SKView) {
        rectangle = childNode(withName: "rectangle") as? SKSpriteNode
        swipeArrow = childNode(withName: "swipe-arrow") as? SKSpriteNode
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    func swipedRight(sender: UISwipeGestureRecognizer){
        print("Object has been swiped")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as! UITouch
        let location = touch.location(in: self)
        
        if (swipeArrow?.frame.contains(location))!{
            print("Swipe has started")
        }
    }
    
    
}
