//
//  RadioScene.swift
//  MC2
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit

class RadioScene: SKScene{
    
    var radioTuner = SKSpriteNode(imageNamed: "radio-tuner")
    var currentRotation: CGFloat = 0
    
    override func didMove(to view: SKView) {
//        radioTuner = SKSpriteNode(imageNamed: "radio-tuner")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        if radioTuner.contains(touchLocation){
            radioTuner.position = touchLocation
            print("masuk")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        rotateTuner()
    }
    
    func rotateTuner(){
        let rotationAmount: CGFloat = 0.1
        
        // Increment rotation
              currentRotation += rotationAmount
              
          // Wrap rotation back to 0 degrees if it exceeds 360 degrees
          if currentRotation > 360 {
              currentRotation -= 360
          }
          
          // Apply rotation to the tuner node
          radioTuner.zRotation = currentRotation * .pi / 180.0
        
        
    }
}
