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
    
    //array yang menampung 2 variabel untuk cek apakah ud match
    var currentSelectKeypads: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        
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
        for touch in touches {
            let location = touch.location(in: self)
            
            //validation to check if they are "matchNumbers" child node
            guard let matchNumbersNode = childNode(withName: "matchNumbers") as? SKNode else {
                return
            }
            
            //if the touch location is already at the spritenode
            if let touchedNode = atPoint(location) as? SKSpriteNode {
                //cek lagi kalau parentnya bukan matchNumbersNode
                if touchedNode.parent != matchNumbersNode {
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
}

