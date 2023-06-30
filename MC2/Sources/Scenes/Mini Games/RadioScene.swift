//
//  RadioScene.swift
//  MC2
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit

class RadioScene: SKScene{
    
    var radioTuner: SKSpriteNode = SKSpriteNode()
    let rotateRecognizer = UIRotationGestureRecognizer()
    
    var rotation: CGFloat = 0
    
    //remembers what the previous rotation was
    var offset: CGFloat = 0
    
    override func didMove(to view: SKView) {
        if let radioTunerNode: SKSpriteNode = self.childNode(withName: "radio-tuner") as? SKSpriteNode{
            radioTuner = radioTunerNode
        }
        
        rotateRecognizer.addTarget(self, action: #selector(RadioScene.rotatedView(_:)))
        self.view!.addGestureRecognizer(rotateRecognizer)
    }
    
    //Get information from gesture recognizer
    @objc func rotatedView(_ sender:UIRotationGestureRecognizer){
        
        if (sender.state == .began){
            print("began")
        }
        
        if(sender.state == .changed){
            print("rotated")
            
            rotation = CGFloat(sender.rotation) + self.offset
            rotation = rotation * -1
            
            radioTuner.zRotation = rotation
        }
        
        if(sender.state == .ended){
            print("ended")
            
            self.offset = radioTuner.zRotation
            
        }
        
    }
    
//    override func update(_ currentTime: TimeInterval) {
//        <#code#>
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        <#code#>
//    }
    

}
