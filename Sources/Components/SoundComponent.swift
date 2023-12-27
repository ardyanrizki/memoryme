//
//  SoundComponent.swift
//  Memoryme
//
//  Created by Ivan on 02/07/23.
//

import AVFoundation
import GameplayKit

/// `SoundComponent` is responsible for managing the audio playback of a sound file.
class SoundComponent: GKComponent {
    
    /// The audio player for playing the sound.
    var soundPlayer: AVAudioPlayer?
    
    /// Initializes a sound component with the specified sound file.
    /// - Parameter soundFile: The name of the sound file (including extension) to be played.
    init(soundFile: String) {
        super.init()
        
        // Attempt to locate the sound file in the main bundle.
        guard let soundPath = Bundle.main.path(forResource: soundFile, ofType: nil) else {
            print("Failed to locate sound file.")
            return
        }
        
        let soundUrl = URL(fileURLWithPath: soundPath)
        
        do {
            // Initialize the audio player with the sound file URL.
            soundPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            
            // Prepare the audio player for playback.
            soundPlayer?.prepareToPlay()
            
            // Enable rate adjustment for the audio player.
            soundPlayer?.enableRate = true
            
            // Set the initial volume for the audio player.
            soundPlayer?.volume = 0.5
        } catch {
            print("Failed to initialize sound player: \(error)")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(.initCoderNotImplemented)
    }
}
