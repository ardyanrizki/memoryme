//
//  RadioScene.swift
//  MC2
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit
import AVFoundation

class RadioScene: SKScene, SKPhysicsContactDelegate{
    
    var radioTuner: SKSpriteNode!
    var radioPointer: SKSpriteNode!
    var radioPointerPosition: CGPoint = .zero
    var horizontalDistance: CGFloat = 0.0
    //starting angle dari touch kita
    var startingAngle: CGFloat = 0
    //starting angle dari radio
    var radioStartingAngle: CGFloat = 0
    var draggingTouch: UITouch?
    
    var targetFrequencyNode: SKSpriteNode!
    var startNode: SKNode!
    var endNode: SKNode!
    
    var audioPlayer: AVAudioPlayer?
    var isPlayingSound: Bool = false
    
    override func didMove(to view: SKView) {
        radioTuner = self.childNode(withName: "radio-tuner") as? SKSpriteNode
        radioPointer = self.childNode(withName: "radio-pointer") as? SKSpriteNode
        radioPointerPosition = radioPointer.position
        targetFrequencyNode = self.childNode(withName: "targetFrequencyNode") as? SKSpriteNode
        startNode = self.childNode(withName: "startNode")
        endNode = self.childNode(withName: "endNode")
        
        //horizontal distance between line of FM
        if startNode != nil && endNode != nil{
            horizontalDistance = abs(endNode.position.x - startNode.position.x)
        }
        
        do {
            let audioPath = Bundle.main.path(forResource: "cutscene-bar", ofType: "mp3")
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
        
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
            var angleChange = angle - startingAngle
            
            //convert dari derajat ke radian krn zrotation hanya dlm bentuk radian
            radioTuner.zRotation = radioStartingAngle + angleChange
            
            //menentukan minimum rotation -> pakai fungsi max
            //zrotation dan 359 dibandingkan, bakal diambil yang lebih kecil
            radioTuner.zRotation = min(radioTuner.zRotation, (90.0).toRadians())
            
            //menentukan maximum rotation -> pakai fungsi min
            radioTuner.zRotation = max(radioTuner.zRotation, (-269.0).toRadians())
            
            let fullRotationAngle: CGFloat = (90.0 + 269.0).toRadians()
            let normalizedDistance = (radioTuner.zRotation - radioStartingAngle) / fullRotationAngle
            
            let targetX = startNode.position.x - (normalizedDistance * horizontalDistance)
            
            // Set the boundaries
            let minX = startNode.position.x
            let maxX = endNode.position.x
            
            // Limit the pointer's position within the boundaries
            radioPointer.position.x = max(min(targetX, maxX), minX)
            
            let intersectsTargetNode = radioPointer.frame.intersects(targetFrequencyNode.frame)
                       
           if intersectsTargetNode && !isPlayingSound {
               audioPlayer?.play()
               isPlayingSound = true
           } else if !intersectsTargetNode && isPlayingSound {
               audioPlayer?.stop()
               isPlayingSound = false
           }
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
    


