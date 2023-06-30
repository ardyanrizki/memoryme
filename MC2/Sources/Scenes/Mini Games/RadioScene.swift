//
//  RadioScene.swift
//  MC2
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit

class RadioScene: SKScene{
<<<<<<< HEAD

    var radioTuner: SKSpriteNode!
    var radioPointer: SKSpriteNode!
    //starting angle dari touch kita
    var startingAngle: CGFloat = 0
    //starting angle dari radio
    var radioStartingAngle: CGFloat = 0
    var draggingTouch: UITouch?
  
    override func didMove(to view: SKView) {
        radioTuner = self.childNode(withName: "radio-tuner") as? SKSpriteNode
        radioPointer = self.childNode(withName: "radio-pointer") as? SKSpriteNode
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // panggil sekali
        //menyimpan touch
        guard let touch = touches.first else { return }
        //menyimpan lokasi touch
        let touchLocation = touch.location(in: self)
        
        if radioTuner.contains(touchLocation) {
            //saat touch radio, id nya disimpan
            draggingTouch = touch
            
            //untuk menjadikan tengah radio tuner sebagai anchor
            let direction = CGPoint(x: touchLocation.x - radioTuner.position.x, y: touchLocation.y - radioTuner.position.y)
            
            //detect angle awal waktu di touch radio tunernya
            startingAngle = atan2(direction.y, direction.x)
            radioStartingAngle = radioTuner.zRotation
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // dipanggil setiap ada jari yang digerakin
        
        //harus di redefine
        //menyimpan touch
        guard let touch = touches.first else { return }
        //menyimpan lokasi touch
        let touchLocation = touch.location(in: self)
        
        //dicek apakah jari yg bergerak sama dengan jari yg sentuh radio tuner di awal
        if let draggingTouch, draggingTouch == touch{
            
            //untuk menjadikan tengah radio tuner sebagai anchor
            let direction = CGPoint(x: touchLocation.x - radioTuner.position.x, y: touchLocation.y - radioTuner.position.y)
            
            //atan2 = tan -> posisi ke derajat
            let angle = atan2(direction.y, direction.x)
            //perubahan angle
            let angleChange = angle - startingAngle
            
            //convert dari derajat ke radian krn zrotation hanya dlm bentuk radian
            radioTuner.zRotation = radioStartingAngle + angleChange
            
            //menentukan minimum rotation -> pakai fungsi max
            //zrotation dan 359 dibandingkan, bakal diambil yang lebih kecil
            radioTuner.zRotation = min(radioTuner.zRotation, (90.0).toRadians())
            
            //menentukan maximum rotation -> pakai fungsi min
            radioTuner.zRotation = max(radioTuner.zRotation, (-269.0).toRadians())
            
            print(radioTuner.zRotation.toDegrees())
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { //panggil sekali
        guard let touch = touches.first else { return }
        
        //kalau jari yang dilepas sama dengan jari yg disentuh di awal, maka udah gaad yg nyentuh di radio lagi
        if let draggingTouch, draggingTouch == touch{
            self.draggingTouch = nil
        }
    }
    
    //Kalau touchnya gajadi
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        //kalau jari yang dilepas sama dengan jari yg disentuh di awal, maka udah gaad yg nyentuh di radio lagi
        if let draggingTouch, draggingTouch == touch{
            self.draggingTouch = nil
        }
    }

}

extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}

extension CGFloat {
    func toDegrees() -> Double {
        return self / .pi * 180.0
    }
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}
=======
    
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
>>>>>>> main
