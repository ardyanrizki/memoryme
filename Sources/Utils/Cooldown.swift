//
//  Cooldown.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 03/07/23.
//

import Foundation

class Cooldown {
    
    static let shared = Cooldown()
    
    private var isOnCooldown = false
    
    func startCooldown(duration: TimeInterval, action: @escaping () -> Void) {
        if isOnCooldown {
            // If already on cooldown, do nothing.
            return
        } else {
            action()
        }
        
        isOnCooldown = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isOnCooldown = false
        }
    }
}
