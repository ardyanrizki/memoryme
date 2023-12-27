//
//  AudioPlayerManager.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 10/07/23.
//

import Foundation
import AVFoundation

enum AudioFileIdentifier: String {
    //BGM
    case ambience = "ambience.mp3"
    case officeSnapshotsBGM = "cutscene-office.mp3"
    case barSnapshotsBGM = "cutscene-bar.mp3"
    case bedroomSnapshotsBGM = "cutscene-bedroom.mp3"
    
    //SFX
    case radioStatic = "radio-static.mp3"
    case truckHorn = "truck-horn.mp3"
    case footSteps = "foot-steps.mp3"
    case click = "keyboard-click.mp3"
    case door = "door.mp3"
    case phone = "phone.mp3"
    case burn = "burn.mp3"
    case lighter = "lighter.mp3"
}

struct AudioPlayer {
    var player: AVAudioPlayer
    
    var identifier: String
        
    init(soundFile: AudioFileIdentifier) {
        do {
            guard let filePath = Bundle.main.path(forResource: soundFile.rawValue, ofType: nil) else {
                fatalError("Failed to locate sound file.")
            }
            
            let soundUrl = URL(fileURLWithPath: filePath)
            player = try AVAudioPlayer(contentsOf: soundUrl)
            player.prepareToPlay()
            player.enableRate = true
            player.volume = 0.5
            identifier = soundFile.rawValue
        } catch {
            fatalError("Failed to initialize sound player: \(error.localizedDescription)")
        }
    }
}

class AudioPlayerManager {
    
    private var library = [AudioPlayer]()
    
    func add(fileName: AudioFileIdentifier) {
        guard library.first(where: { $0.identifier == fileName.rawValue }) == nil else {
            return
        }
        let audio = AudioPlayer(soundFile: fileName)
        library.append(audio)
    }
    
    func remove(fileName: AudioFileIdentifier) {
        library.removeAll(where: { $0.identifier == fileName.rawValue })
    }
    
    func removeAll() {
        library.removeAll()
    }
    
    func play(fileName: AudioFileIdentifier) {
        library.first(where: { $0.identifier == fileName.rawValue })?.player.play()
    }
    
    func stop(fileName: AudioFileIdentifier) {
        library.first(where: { $0.identifier == fileName.rawValue })?.player.stop()
    }
    
    func stopAll() {
        library.forEach { $0.player.stop() }
    }
    
    func setVolume(_ value: Float, fileName: AudioFileIdentifier) {
        library.first(where: { $0.identifier == fileName.rawValue })?.player.volume = value
    }
}
