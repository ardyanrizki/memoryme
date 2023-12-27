//
//  AudioPlayerManager.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 10/07/23.
//

import Foundation
import AVFoundation

/// Enumeration representing different types of audio players.
enum AudioPlayerType {
    /// Background audio player type.
    case background
    /// Sound effect audio player type.
    case soundEffect
}

/// Manages audio playback using AVAudioPlayer.
class AudioPlayerManager: NSObject {
    
    /// The collection of audio players.
    private var library: [AudioPlayer] = []
    
    /// Plays an audio file.
    ///
    /// - Parameters:
    ///   - audioFile: The identifier of the audio file to play.
    ///   - type: The type of the audio player (background or sound effect).
    ///   - playingTimes: The number of times to play the audio file.
    ///   - volume: The volume level of the audio player.
    ///   - forcePlay: If true, the audio will play even if it's already playing.
    func play(audioFile: AudioFile, type: AudioPlayerType, playingTimes: Int = 1, volume: Float = 0.5, forcePlay: Bool = false) {
        if let audioPlayer = library.first(where: { $0.audioFile == audioFile }) {
            if forcePlay || !audioPlayer.player.isPlaying {
                audioPlayer.player.play()
            }
        } else {
            if type == .background, let audioPlayerIndex = library.firstIndex(where: { $0.type == .background }) {
                library[audioPlayerIndex].player.stop()
                guard let audioPlayer = AudioPlayer(audioFile: audioFile, type: type, playingTimes: playingTimes, volume: volume) else {
                    return
                }
                audioPlayer.player.delegate = self
                audioPlayer.player.play()
                library.remove(at: audioPlayerIndex)
                library.append(audioPlayer)
            } else {
                guard let audioPlayer = AudioPlayer(audioFile: audioFile, type: type, playingTimes: playingTimes, volume: volume) else {
                    return
                }
                audioPlayer.player.delegate = self
                audioPlayer.player.play()
                library.append(audioPlayer)
            }
        }
    }
    
    /// Stops all audio playback and clears the library.
    func removeAll() {
        library.removeAll()
    }
    
    /// Stops all background audio playback.
    func stopBackgroundAudio() {
        let backgroundAudioPlayers = library.filter({ $0.type == .background })
        for backgroundAudioPlayer in backgroundAudioPlayers {
            stop(audioFile: backgroundAudioPlayer.audioFile)
        }
    }
    
    /// Stops audio playback for a specific audio file.
    ///
    /// - Parameter audioFile: The identifier of the audio file to stop.
    func stop(audioFile: AudioFile) {
        guard let index = library.firstIndex(where: { $0.audioFile == audioFile }) else {
            return
        }
        library[index].player.stop()
        library.remove(at: index)
    }
    
    /// Pauses audio playback for a specific audio file.
    ///
    /// - Parameter audioFile: The identifier of the audio file to pause.
    func pause(audioFile: AudioFile) {
        library.first(where: { $0.audioFile == audioFile })?.player.pause()
    }
    
    /// Stops all audio playback.
    func stopAll() {
        library.forEach { $0.player.stop() }
        removeAll()
    }
    
    /// Sets the volume level for a specific audio file.
    ///
    /// - Parameters:
    ///   - audioFile: The identifier of the audio file.
    ///   - value: The volume level to set.
    func setVolume(audioFile: AudioFile, to value: Float) {
        library.first(where: { $0.audioFile == audioFile })?.player.volume = value
    }
}

extension AudioPlayerManager: AVAudioPlayerDelegate {
    
    /// Handles the completion of audio playback.
    ///
    /// - Parameters:
    ///   - player: The audio player that finished playing.
    ///   - flag: Indicates whether playback was successful.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let audioPlayerIndex = library.firstIndex(where: { $0.player == player }) {
            if library[audioPlayerIndex].type == .background {
                library[audioPlayerIndex].player.play()
                return
            }
            
            if library[audioPlayerIndex].playingTimes > 1 {
                library[audioPlayerIndex].playingTimes -= 1
                library[audioPlayerIndex].player.play()
                return
            }
            
            library.remove(at: audioPlayerIndex)
        }
    }
}
