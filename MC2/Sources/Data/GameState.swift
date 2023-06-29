//
//  GameState.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 27/06/23.
//

import Foundation

enum GameEvent {
    case opening
    case exploring
    case dialog
    case snapshots
    case minigame
}

enum StateKey: String {
    case sceneActivity
    case momsCallAccepted
    case friendsPhotosKept
    case strangerSaved
}

enum StateValue: Equatable {
    case intValue(Int)
    case stringValue(String)
    case floatValue(Float)
    case boolValue(Bool)
    case gameEventValue(GameEvent)
}

protocol GameStateCentralDelegate: AnyObject {
    func didUpdate(_ variable: StateKey?, value: StateValue?)
}

class GameState {
    
    private var states: [StateKey: StateValue] = [:]
    
    var delegate: GameStateCentralDelegate?
    
    func setState(key: StateKey, value: StateValue) {
        states[key] = value
        delegate?.didUpdate(key, value: value)
    }
    
    func getState(key: StateKey) -> StateValue? {
        return states[key]
    }
    
    func getStates(of stateKeys: [StateKey]? = nil) -> [StateKey: StateValue] {
        if let stateKeys {
            return states.filter{ stateKeys.contains($0.key) }
        }
        return states
    }
    
    func removeState(key: StateKey) {
        states[key] = nil
        delegate?.didUpdate(key, value: nil)
    }
    
    func removeAllStates() {
        states.removeAll()
        delegate?.didUpdate(nil, value: nil)
    }
    
}
