//
//  GameStateValue.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import Foundation

/**
 Represents a state value that can hold different types of data.
 */
enum GameStateValue: Equatable {
    /// An integer value.
    case intValue(Int)
    
    /// A string value.
    case stringValue(String)
    
    /// A floating-point value.
    case floatValue(Float)
    
    /// A boolean value.
    case boolValue(Bool)
    
    /// A value representing a scene activity.
    case sceneActivityValue(GameActivity)
    
    /**
     Compares the current GameStateValue with a provided value of generic type T.
     
     - Parameters:
        - value: The value to compare with.
     
     - Returns: `true` if the values are equal, `false` otherwise.
     */
    func isEqual<T: Equatable>(with otherValue: T) -> Bool {
        switch self {
        case .intValue(let intValue):
            if let otherIntValue = otherValue as? Int {
                return intValue == otherIntValue
            }
        case .stringValue(let stringValue):
            if let otherStringValue = otherValue as? String {
                return stringValue == otherStringValue
            }
        case .floatValue(let floatValue):
            if let otherFloatValue = otherValue as? Float {
                return floatValue == otherFloatValue
            }
        case .boolValue(let boolValue):
            if let otherBoolValue = otherValue as? Bool {
                return boolValue == otherBoolValue
            }
        case .sceneActivityValue(let activityValue):
            if let otherActivityValue = otherValue as? GameActivity {
                return activityValue == otherActivityValue
            }
        }
        return false
    }
}
