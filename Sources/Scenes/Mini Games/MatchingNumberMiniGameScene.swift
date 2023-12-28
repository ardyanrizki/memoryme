//
//  MatchingNumberMiniGameScene.swift
//  Memoryme
//
//  Created by Clarabella Lius on 26/06/23.
//

import SpriteKit
import GameplayKit

class MatchingNumberMiniGameScene: GameScene {
    
    // represent match number node in mini game
    var matchNumberParentNode: SKNode!
    
    // represent email screen on macbook
    var macBookEmailScreen: SKNode!
    
    // represent verification screen on macbook
    var macBookVerificationScreen: SKNode!
    
    // TODO: move this value to State Machine
    var touchEventsEnabled: Bool = true
    
    //array yang menampung 2 variabel untuk cek apakah ud match
    var currentSelectKeypads: [SKSpriteNode] = []
    
    func matchingNumberCompletion() async {
        touchEventsEnabled = false
        macBookVerificationScreen.alpha = 0
        matchNumberParentNode.alpha = 0
        
        macBookEmailScreen.alpha = 1
        
        await dialogBox?.start(dialogs: DialogResources.office4EmailSequence, from: self)
        self.touchEventsEnabled = true
        self.sceneManager?.presentWorkingSnapshots()
    }
}

// MARK: Overrided methods.
extension MatchingNumberMiniGameScene {
    
    override func didMove(to view: SKView) {
        matchNumberParentNode = childNode(withName: "matchNumbers")
        macBookVerificationScreen = childNode(withName: TextureResources.macbookVerificationScreen)
        macBookEmailScreen = childNode(withName: TextureResources.macbookEmailScreen)
        
        setupDialogBox()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if currentSelectKeypads.count == 2 {
            // if keypad has same name, remove those keypads from parent
            if currentSelectKeypads[0].name == currentSelectKeypads[1].name {
                currentSelectKeypads.forEach { keypadNode in
                    keypadNode.removeFromParent()
                }
            } else {
                // otherwise, change texture of current selected keypads into inactive mode
                currentSelectKeypads.forEach { keypadNode in
                    let newTexture = SKTexture(imageNamed: "\(keypadNode.name!)_inactive")
                    keypadNode.texture = newTexture
                }
            }
            
            currentSelectKeypads = []
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        for touch in touches {
            let location = touch.location(in: self)
            
            //if the touch location is already at the spritenode
            if let touchedNode = atPoint(location) as? SKSpriteNode {
                //cek lagi kalau parentnya bukan matchNumbersNode
                if touchedNode.parent != matchNumberParentNode {
                    return
                }
                
                // Make selected keypad into active mode by changing its texture
                let newTexture = SKTexture(imageNamed: "\(touchedNode.name!)_active")
                touchedNode.texture = newTexture
                
                // assign the touched keypad to the state
                currentSelectKeypads.append(touchedNode)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else {
            return
        }
        
        guard let backLabelNode = childNode(withName: TextureResources.backButton) as? SKSpriteNode else {
            return
        }
        
        let touchedLocation = touch.location(in: self)
        
        // To handle back button
        if backLabelNode.contains(touchedLocation) {
            let fade = SKTransition.fade(withDuration: 0.5)
            sceneManager?.presentOffice(playerPosition: .officeComputerSpot, transition: fade)
            return
        }
        
        // To handle completion match number game.
        // Triggered if the number is left one
        if let matchNumbers = matchNumberParentNode?.children, 
            matchNumbers.count <= 1 {
            Task {
                await matchingNumberCompletion()
            }
        }
    }
}
