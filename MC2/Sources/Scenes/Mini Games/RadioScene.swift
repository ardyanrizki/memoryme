//
//  RadioScene.swift
//  MC2
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit
import AVFoundation

class RadioScene: SKScene{

    var radioTuner: SKSpriteNode!
    var radioPointer: SKSpriteNode!
    var targetFrequencyNode: SKNode!
    //starting angle dari touch kita
    var startingAngle: CGFloat = 0
    //starting angle dari radio
    var radioStartingAngle: CGFloat = 0
    var previousAngleOffset: CGFloat = 0
    var draggingTouch: UITouch?
    
    var audioPlayer: AVAudioPlayer!
    var isPlayingSound: Bool = false
  
    override func didMove(to view: SKView) {
        radioTuner = self.childNode(withName: "radio-tuner") as? SKSpriteNode
        radioPointer = self.childNode(withName: "radio-pointer") as? SKSpriteNode
        targetFrequencyNode = self.childNode(withName: "targetFrequencyNode")
        
        // Play the initial background music
        playBackgroundMusic(filename: "radio-static.mp3")
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
            let touchLocationInRadio = CGPoint(x: touchLocation.x - radioTuner.position.x, y: touchLocation.y - radioTuner.position.y)
            
            //detect angle awal waktu di touch radio tunernya
            startingAngle = atan2(touchLocationInRadio.x, touchLocationInRadio.y)
            previousAngleOffset = 0.0
            
            var radioRotation = radioTuner.zRotation
            if radioRotation > 0.0 {
                radioRotation -= (360.0).toRadians()
            }
            radioStartingAngle = radioRotation
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
            let touchLocationInRadio = CGPoint(x: touchLocation.x - radioTuner.position.x, y: touchLocation.y - radioTuner.position.y)
            
            let currentAngle = atan2(touchLocationInRadio.x, touchLocationInRadio.y)
            var angleOffset = currentAngle - startingAngle
             
            let angleDifference = angleOffset - previousAngleOffset
            if angleDifference >= (270.0).toRadians() {
                let multiplier = getAngleMultiplier(Int(angleDifference.toDegrees()))
                angleOffset -= (360.0 * Double(multiplier)).toRadians()
            }
            else if angleDifference <= (-270.0).toRadians() {
                let multiplier = getAngleMultiplier(Int(-angleDifference.toDegrees()))
                angleOffset += (360.0 * Double(multiplier)).toRadians()
            }
            
            previousAngleOffset = angleOffset
            
            var newRotation = radioStartingAngle - angleOffset
            newRotation = min(newRotation, (0.0).toRadians())
            newRotation = max(newRotation, (-359.0).toRadians())
            
            radioTuner.zRotation = newRotation
            
            radioPointer.position.x = getPositionFromAngle(newRotation.toDegrees())
            print(radioPointer.position.x)
            if radioPointer.position.x > 120 && radioPointer.position.x < 160 && !isPlayingSound {
                changeBackgroundMusic(filename: "cutscene-bar.mp3")
                isPlayingSound = true
            } else if isPlayingSound && (radioPointer.position.x <= 120 || radioPointer.position.x >= 160) {
                changeBackgroundMusic(filename: "radio-static.mp3")
                isPlayingSound = false
            }
        }
    }
    
    func getAngleMultiplier(_ number: Int) -> Int {
        let normalizedNumber = (number - 270) % (360 * 360)
        let result = (normalizedNumber / 360) + 1
        return result
    }
    
    func getPositionFromAngle(_ value: Double) -> Double {
        let fromMin = 0.0
        let fromMax = -359.0
        let toMin = -320.0
        let toMax = 270.0
        
        let linearInterpolation = (value - fromMin) * (toMax - toMin) / (fromMax - fromMin) + toMin
        return linearInterpolation
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

extension RadioScene {
    func playBackgroundMusic(filename: String) {
        // Stop the current background music if playing
        stopBackgroundMusic()
        
        // Get the path to the new music file
        let filePath = Bundle.main.path(forResource: filename, ofType: nil)
        if let path = filePath {
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create the audio player
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                
                // Configure the audio player settings
                audioPlayer.numberOfLoops = -1 // Loop indefinitely
                audioPlayer.volume = 0.5 // Adjust the volume as needed
                
                // Play the background music
                audioPlayer.play()
            } catch {
                // Error handling if the audio player fails to initialize
                print("Could not create audio player: \(error.localizedDescription)")
            }
        } else {
            print("Music file not found: \(filename)")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    // Example function to change the background music during gameplay
    func changeBackgroundMusic(filename: String) {
        playBackgroundMusic(filename: filename)
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
