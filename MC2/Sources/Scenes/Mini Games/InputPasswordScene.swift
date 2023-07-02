//
//  InputPasswordScene.swift
//  MC2
//
//  Created by Clarabella Lius on 21/06/23.
//

import SpriteKit
import GameplayKit

class TextField: SKNode{ //-> Node kosong, SpriteNode = gambar
    
    //referensi node ke posisi
    //sekalian assign array kosong
    var positionNodes = [SKNode]()
    
    //array untuk tampung yang sudah diketik
    var numberNodes = [SKSpriteNode]()
    var incorrectPinText: SKSpriteNode!
    
    //representasi berapa angka di text fieldnya
    var digitCount = 0
    
    //ditentukan kode passcode untuk unlock
    let unlockCombination = "0508"
    
    //representasi kombinasi yang sedang dimasukkan
    var enteredCombination = ""
    
    //initialize variable
    func setup(){
        for pos in self.children{
            if pos.name == TextureResources.incorrectPinText {
                incorrectPinText = self.childNode(withName: TextureResources.incorrectPinText) as? SKSpriteNode
            } else {
                positionNodes.append(pos)
            }
        }
    }
    
    // fungsi untuk munculin angka kalau di click keypad
    func fillNumber(
        number: Int,
        completion: (() -> Void)
    ) {
        
        if digitCount >= 4 { return }
        
        //ngebuat node baru dengan gambar sesuai dgn gambar angka
        let numberSprite = SKSpriteNode(imageNamed: "num\(number)")
        
        //name untuk spritenode
        numberSprite.name = "num\(number)"
        
        //menjadikan spritenode angka sebagai child dari scene
        scene?.addChild(numberSprite)
        numberNodes.append(numberSprite)
        
        //set posisi dari sprite untuk sama dengan posisi dari node nya
        numberSprite.position = positionNodes[digitCount].parent!.convert(
            positionNodes[digitCount].position, to: scene!)
        
        // Workaround to set pin number's z position same as the screen
        numberSprite.zPosition = 2
        
        enteredCombination += "\(number)"
        
        //nambahin representasi jumlah digit
        digitCount += 1
        
        if digitCount == 4 {
            if enteredCombination == unlockCombination {
                for numberNode in numberNodes {
                    numberNode.alpha = 0
                }
                
                completion()
            } else {
                incorrectPinText.alpha = 1
            }
        }
    }
    
    func deleteNumber(){
        
        if digitCount <= 0 { return }
        
        //representasi jumlah digit berkurang
        digitCount -= 1
        
        // hide incorrect pin if it displayed previously
        if incorrectPinText.alpha > 0 {
            incorrectPinText.alpha = 0
        }
        
        //remove dari scene
        numberNodes[digitCount].removeFromParent()
        
        //remove dari array
        numberNodes.remove(at: digitCount)
        
        enteredCombination.removeLast()
    }
}

// MARK: Overrided methods.
class InputPasswordScene: SKScene {
    
    var sceneManager: SceneManagerProtocol?
    
    var keypads: [KeypadNode]! //declare suatu array namanya keypads dengan tipe KeyPad
    var deleteButton: SKSpriteNode!
    var macbookLoginScreen: SKSpriteNode!
    var textField: TextField!
    
    // TODO: move this value to State Machine
    var touchEventsEnabled: Bool = true
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
    
    override func didMove(to view: SKView) {//hanya dijalanin sekali pas awal scene
        //Nyari laptopNode dan dimasukin ke variabel
        let laptop = childNode(withName: TextureResources.macbookCloseUp)!
        
        macbookLoginScreen = childNode(withName: TextureResources.macbookLoginScreen) as? SKSpriteNode
        
        //assign array kosong ke keypads
        keypads = [KeypadNode]()
        
        //Looping untuk semua childnya
        for node in laptop.children{
            //cek apakah dia termasuk class Keypads
            if let keypad = node as? KeypadNode {
                keypad.setup()
                keypads.append(keypad)
            }
        }
        deleteButton = laptop.childNode(withName: "delete") as? SKSpriteNode
        
        //variabel referensi ke textfield yg di scene
        //kalau ga di type cast by default sknode
        textField = laptop.childNode(withName: "TextField") as? TextField
        textField.setup()
        
        setupDialogBox()
        self.dialogBox?.start(dialog: DialogResources.office_3_computer, from: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchEventsEnabled else { return }
        //detect touch location
        let location = touches.first!.location(in: self)

        
        for keypad in keypads{
            //cek apakah lokasi touch ada di keypad
            if keypad.contains(location) {
                textField.fillNumber(
                    number: keypad.number,
                    completion: handleComplePin
                )
            }
        }
        
        if deleteButton.contains(location) {
            textField.deleteNumber()
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
        if backLabelNode.contains(touchedLocation) {
            sceneManager?.presentOfficeRoomScene(playerPosition: .computerSpot)
        }
    }
}

// MARK: Event method.
extension InputPasswordScene {
    
    func handleComplePin() {
        touchEventsEnabled = false
        macbookLoginScreen.alpha = 1
        
        let fadeAction = SKAction.fadeAlpha(to: 0, duration: 0.5)
        let intervalAction = SKAction.wait(forDuration: 0.5)
        let presentNewScreen = SKAction.run {
            self.sceneManager?.presentMGMatchingNumbersScene()
        }
        
        var actions = [SKAction]()
        actions.append(contentsOf: [
            fadeAction,
            intervalAction,
            presentNewScreen
        ])
        
        let sequencedActions = SKAction.sequence(actions)
        macbookLoginScreen.run(sequencedActions)
    }
    
    /**
     Setup dialog box.
     */
    private func setupDialogBox() {
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
}
