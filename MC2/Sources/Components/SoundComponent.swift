//
//  SoundComponent.swift
//  MC2
//
//  Created by Ivan on 02/07/23.
//

import Foundation
import AVFoundation
import GameplayKit

class SoundComponent: GKComponent {
    var soundPlayer: AVAudioPlayer?
        
    init(soundFile: String) {
        super.init()
        
        guard let soundPath = Bundle.main.path(forResource: soundFile, ofType: nil) else {
            print("Failed to locate sound file.")
            return
        }
        
        let soundUrl = URL(fileURLWithPath: soundPath)
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            soundPlayer?.prepareToPlay()
            soundPlayer?.enableRate = true
            soundPlayer?.volume = 0.5
            
            print("ready to play \(soundUrl)")
        } catch {
            print("Failed to initialize sound player: \(error)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
}
