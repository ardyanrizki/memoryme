//
//  InputPasswordScene.swift
//  MC2
//
//  Created by Clarabella Lius on 21/06/23.
//

import SpriteKit
import GameplayKit

class KeyPad: SKSpriteNode{
   var number = 0
    
    //initialize variable
    func setup(){
        //access "number" di userdata - check if its null - typecasting value to Int
        number = userData?["number"] as! Int
    }
}

class TextField: SKNode{ //-> Node kosong, SpriteNode = gambar
    
    //referensi node ke posisi
    //sekalian assign array kosong
    var positionNodes = [SKNode]()
    
    //array untuk tampung yang sudah diketik
    var numberNodes = [SKSpriteNode]()
    
    //representasi berapa angka di text fieldnya
    var digitCount = 0
    
    //ditentukan kode passcode untuk unlock
    let unlockCombination = "2406"
    
    //representasi kombinasi yang sedang dimasukkan
    var enteredCombination = ""
    
    //initialize variable
    func setup(){
        for pos in self.children{
            positionNodes.append(pos)
        }
    }
    
    func fillNumber(number: Int){ //fungsi untuk munculin angka kalau di click keypad
        
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
        
        enteredCombination += "\(number)"
        
        //nambahin representasi jumlah digit
        digitCount += 1
        
        if digitCount == 4 {
            if enteredCombination == unlockCombination {
                print("anda benar!!! pindah scene")
            }
        }
    }
    
    func deleteNumber(){
        
        if digitCount <= 0 { return }
        
        //representasi jumlah digit berkurang
        digitCount -= 1
        
        //remove dari scene
        numberNodes[digitCount].removeFromParent()
        
        //remove dari array
        numberNodes.remove(at: digitCount)
        
        enteredCombination.removeLast()
    }
    
}


class InputPasswordScene: SKScene{
    
    var keypads: [KeyPad]! //declare suatu array namanya keypads dengan tipe KeyPad
    var deleteButton: SKSpriteNode!
    var textField: TextField!
    
    
    override func didMove(to view: SKView) {//hanya dijalanin sekali pas awal scene
        //Nyari laptopNode dan dimasukin ke variabel
        let laptop = childNode(withName: "MacbookLogin")!
        
        //assign array kosong ke keypads
        keypads = [KeyPad]()
        
        //Looping untuk semua childnya
        for node in laptop.children{
            //cek apakah dia termasuk class Keypads
            if let keypad = node as? KeyPad {
                keypad.setup()
                keypads.append(keypad)
            }
        }
        deleteButton = laptop.childNode(withName: "delete") as? SKSpriteNode
        
        //variabel referensi ke textfield yg di scene
        //kalau ga di type cast by default sknode
        textField = laptop.childNode(withName: "TextField") as? TextField
        textField.setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //detect touch location
        let location = touches.first!.location(in: self)
        
        for keypad in keypads{
            //cek apakah lokasi touch ada di keypad
            if keypad.contains(location) {
                textField.fillNumber(number: keypad.number)
            }
        }
        
        if deleteButton.contains(location) {
            textField.deleteNumber()
        }
    }
}