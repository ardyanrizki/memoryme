//
//  KeypadNode.swift
//  Memoryme
//
//  Created by Ivan on 30/06/23.
//
import SpriteKit

class KeypadNode: SKSpriteNode{
   var number = 0
    
    //initialize variable
    func setup(){
        //access "number" di userdata - check if its null - typecasting value to Int
        number = userData?["number"] as! Int
    }
}
