//
//  DialogResources.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 24/06/23.
//

import Foundation

struct Dialog {
    let name: String
    let prompt: String
    
    init(_ name: String, prompt: String) {
        self.name = name
        self.prompt = prompt
    }
}

struct DialogResources {
    
    static let strangeVase: Dialog = Dialog(Constants.mainCharacterName, prompt: "This is Vase... Wait there is something strange about the flower")
    
    // TODO: Add anothers dialog here as the static property of `Dialog` type.
}


