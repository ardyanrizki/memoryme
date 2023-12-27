//
//  RadioScene.swift
//  Memoryme
//
//  Created by Clarabella Lius on 29/06/23.
//

import SpriteKit
import GameplayKit

/// A scene where the player interacts with the radio tuner.
class RadioScene: PlayableScene {

    // MARK: - Properties

    var radioTuner: SKSpriteNode!
    var radioPointer: SKSpriteNode!
    var targetFrequencyNode: SKNode!
    var startingAngle: CGFloat = 0
    var radioStartingAngle: CGFloat = 0
    var previousAngleOffset: CGFloat = 0
    var draggingTouch: UITouch?
    var isPlayingSound: Bool = false

    // MARK: - Scene Lifecycle

    override func didMove(to view: SKView) {
        setupDialogBox()
        
        radioTuner = self.childNode(withName: "radio-tuner") as? SKSpriteNode
        radioPointer = self.childNode(withName: "radio-pointer") as? SKSpriteNode
        targetFrequencyNode = self.childNode(withName: "targetFrequencyNode")
        
        audioPlayerManager?.play(audioFile: .radioStatic, type: .background)
        
        Task {
            await dialogBox?.start(dialog: DialogResources.bar2Solo, from: self)
        }
    }

    // MARK: - Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first

        if radioTuner.contains(touchLocation) {
            draggingTouch = touch
            let touchLocationInRadio = CGPoint(x: touchLocation.x - radioTuner.position.x, y: touchLocation.y - radioTuner.position.y)
            startingAngle = atan2(touchLocationInRadio.x, touchLocationInRadio.y)
            previousAngleOffset = 0.0
            
            var radioRotation = radioTuner.zRotation
            if radioRotation > 0.0 {
                radioRotation -= (360.0).toRadians()
            }
            radioStartingAngle = radioRotation
        }
        
        switch(touchedNode?.name) {
            case "back-button":
            scenePresenter?.presentBar(playerPosition: .barRadioSpot, transition: SKTransition.fade(withDuration: 0.5))
                break
            default:
                break
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        if let draggingTouch, draggingTouch == touch {
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
            
            Task {
                if radioPointer.position.x > 120 && !isPlayingSound {
                    isPlayingSound = true
                    await dialogBox?.start(dialog: DialogResources.bar3Solo, from: self)
                    if radioPointer.position.x > 120 {
                        timeout(after: 1.0, node: self) {
                            self.scenePresenter?.presentStrangerSnapshots()
                        }
                    }
                } else if isPlayingSound && (radioPointer.position.x <= 120) {
                    audioPlayerManager?.play(audioFile: .radioStatic, type: .soundEffect)
                    isPlayingSound = false
                }
            }
            
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let draggingTouch, draggingTouch == touch {
            self.draggingTouch = nil
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let draggingTouch, draggingTouch == touch {
            self.draggingTouch = nil
        }
    }

    // MARK: - Helper Functions

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
    
    func timeout(after seconds: TimeInterval, node: SKNode, completion: @escaping () -> Void) {
        let waitAction = SKAction.wait(forDuration: seconds)
        let completionAction = SKAction.run(completion)
        let sequenceAction = SKAction.sequence([waitAction, completionAction])
        node.run(sequenceAction)
    }
}
