//
//  MatchingNumberScene.swift
//  MC2
//
//  Created by Clarabella Lius on 26/06/23.
//

import SpriteKit
import GameplayKit



class MatchingNumberScene: SKScene {
    
    var sceneManager: SceneManagerProtocol?
    
    // represent match number node in mini game
    var matchNumberParentNode: SKNode!
    
    // represent email screen on macbook
    var macbookEmailScreen: SKNode!
    
    // represent verification screen on macbook
    var macbookVerificationScreen: SKNode!
    
    // TODO: move this value to State Machine
    var touchEventsEnabled: Bool = true
    
    //array yang menampung 2 variabel untuk cek apakah ud match
    var currentSelectKeypads: [SKSpriteNode] = []
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    /**
     Setup dialog box.
     */
    private func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
    
    func matchingNumberCompletion() {
        touchEventsEnabled = false
        macbookVerificationScreen.alpha = 0
        matchNumberParentNode.alpha = 0
        
        macbookEmailScreen.alpha = 1
        
        self.dialogBox?.startSequence(dialogs: [
            DialogResources.office_4_email_seq1,
            DialogResources.office_5_email_seq2,
            DialogResources.office_6_email_seq3
        ], from: self, completion: {
            self.touchEventsEnabled = true
            self.sceneManager?.presentOfficeSnapshotScene()
        })
    }
}

// MARK: Overrided methods.
extension MatchingNumberScene {
    
    override func didMove(to view: SKView) {
        matchNumberParentNode = childNode(withName: "matchNumbers")
        macbookVerificationScreen = childNode(withName: TextureResources.macbookVerificationScreen)
        macbookEmailScreen = childNode(withName: TextureResources.macbookEmailScreen)
        
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
            
            //kosongkan array lagi
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
            sceneManager?.presentOfficeRoomScene()
            return
        }
        
        // To handle completion match number game.
        // Triggered if the number is left one
        if let matchNumbers = matchNumberParentNode?.children {
            if matchNumbers.count <= 1 {
                matchingNumberCompletion()
            }
        }
    }
}
