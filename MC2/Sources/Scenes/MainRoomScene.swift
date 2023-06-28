//
//  MainRoomScene.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 15/06/23.
//

import SpriteKit
import GameplayKit

class MainRoomScene: PlayableScene, PlayableSceneProtocol {
    
    // TODO: move this value to State Machine
    var touchEventsEnabled: Bool = true
    
    typealias T = MainRoomScene
    
    static func sharedScene(playerPosition: PositionIdentifier) -> MainRoomScene? {
        let scene = MainRoomScene(fileNamed: Constants.mainRoomScene)
        scene?.setup(playerPosition: playerPosition)
        return scene
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        //startOpeningEvent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        super.touchesCancelled(touches, with: event)
    }
}

// MARK: Scene's Events
extension MainRoomScene {
    
    func startOpeningEvent() {
        touchEventsEnabled = false
        player?.lay(completion: {
            self.dialogBox?.startSequence(dialogs: [
                DialogResources.opening_1_solo_seq1,
                DialogResources.opening_1_solo_seq2,
            ], from: self, completion: {
                self.touchEventsEnabled = true
            })
        })
    }
    
    func changeRoomSceneryAccordingCallEvent(isAccepted: Bool) {
        // If accepted, show opened frame. else show closed
    }
    
    func changeRoomSceneryAccordingPhotoAlbumEvent(isKept: Bool) {
        // If kept, show album in desk. else show broom
    }
    
    func changeVase(stage: Int) {
        // Change base change stage: 1...3
    }
    
    func changeDoor(stage: Int) {
        // Change base change stage: 1...3
    }
    
}
