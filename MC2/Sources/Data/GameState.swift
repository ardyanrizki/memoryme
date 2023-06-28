//
//  GameState.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 27/06/23.
//

import GameplayKit

protocol GameStateCentralDelegate {
    func didUpdate(acceptMomsCall: Bool?)
    func didUpdate(keptFriendsPhotos: Bool?)
    func didUpdate(savedStranger: Bool?)
    func didUpdate(event: GameEvent)
}

class GameStateCentral {
    
    var delegate: GameStateCentralDelegate?
    
    var acceptMomsCall: Bool? {
        didSet {
            delegate?.didUpdate(acceptMomsCall: acceptMomsCall)
        }
    }
    
    var keptFriendsPhotos: Bool? {
        didSet {
            delegate?.didUpdate(keptFriendsPhotos: keptFriendsPhotos)
        }
    }
    
    var savedStranger: Bool? {
        didSet {
            delegate?.didUpdate(savedStranger: savedStranger)
        }
    }
    
    var event: GameEvent = .exploring {
        didSet {
            delegate?.didUpdate(event: event)
        }
    }
    
    var completedEvent: Int {
        var count = 0
        acceptMomsCall != nil ? count += 1 : nil
        keptFriendsPhotos != nil ? count += 1 : nil
        savedStranger != nil ? count += 1 : nil
        return count
    }
}

enum GameEvent {
    case exploring
    case dialog
    case snapshots
    case minigame
}
