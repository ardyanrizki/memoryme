//
//  Extensions.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 26/06/23.
//

import Foundation

// MARK: CGPoint
extension CGPoint {
    
    /// Adds two points and returns the result.
    static func + (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }
    
    /// Adds the second point to the first point and assigns the result to the first point.
    static func += (point1: inout CGPoint, point2: CGPoint) {
        point1 = point1 + point2
    }
    
    /// Subtracts the second point from the first point and returns the result.
    static func - (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
    }
    
    /// Multiplies a point by a scalar value and returns the result.
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    /// Multiplies a scalar value by a point and returns the result.
    static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return point * scalar
    }
    
    /// Returns a normalized version of the point.
    func normalized() -> CGPoint {
        let length = sqrt(x * x + y * y)
        if length != 0.0 {
            return CGPoint(x: x / length, y: y / length)
        } else {
            return CGPoint.zero
        }
    }
    
    /// Returns the length of the point vector.
    func length() -> CGFloat {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
}

// MARK: Double
extension Double {
    
    /// Converts degrees to radians.
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}

// MARK: CGFloat
extension CGFloat {
    
    /// Converts radians to degrees.
    func toDegrees() -> Double {
        return Double(self) / .pi * 180.0
    }
    
    /// Converts degrees to radians.
    func toRadians() -> Double {
        return Double(self) * .pi / 180.0
    }
}

// MARK: String
extension String {
    
    /// An empty string constant.
    static let emptyString = ""
    
    /// Splits the string into an array of substrings using the specified separator.
    func splitIdentifier(with separator: String = "_") -> [String] {
        return self.components(separatedBy: separator)
    }
    
    // MARK: Error Messages
    
    /// Error message for the `init(coder:)` method not being implemented.
    static let initCoderNotImplemented = "init(coder:) has not been implemented"
    
    /// Error message for node not found.
    static let errorNodeNotFound = "error: node not found"
    
    /// Error message for texture not found.
    static let errorTextureNotFound = "error: texture not found"
    
    /// Error message for identifier not found.
    static let errorIdentifierNotFound = "error: identifier not found"
    
    /// Error message for physics body not found.
    static let errorPhysicsBodyNotFound = "error: physics body not found"
    
    /// Error message for renderable item not set.
    static let errorRenderableItemNotSet = "error: renderable item not set."
}
