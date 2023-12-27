//
//  AudioPlayer.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 27/12/23.
//

import AVFoundation

/// Class representing an audio player for playing audio files.
class AudioPlayer {
    /// The AVAudioPlayer instance responsible for playing audio.
    var player: AVAudioPlayer
    
    /// The identifier of the audio file to be played.
    var audioFile: AudioFile
    
    /// The type of audio player (background or sound effect).
    var type: AudioPlayerType
    
    /// The number of times the audio will be played (positive integer).
    var playingTimes: Int
    
    /// Initializes an audio player with the specified parameters.
    ///
    /// - Parameters:
    ///   - audioFile: The identifier of the audio file to be played.
    ///   - type: The type of audio player (background or sound effect).
    ///   - playingTimes: The number of times the audio will be played (positive integer).
    ///   - volume: The volume level of the audio (clamped to a range of 0 to 1).
    init?(audioFile: AudioFile, type: AudioPlayerType, playingTimes: Int, volume: Float) {
        guard let filePath = Bundle.main.path(forResource: audioFile.rawValue, ofType: nil) else {
            return nil
        }
        
        let soundUrl = URL(fileURLWithPath: filePath)
        do {
            self.player = try AVAudioPlayer(contentsOf: soundUrl)
            self.player.prepareToPlay()
            self.player.enableRate = true
            self.player.volume = max(0, min(1, volume))
            
            self.audioFile = audioFile
            self.type = type
            self.playingTimes = max(1, playingTimes)
        } catch {
            return nil
        }
    }
}
