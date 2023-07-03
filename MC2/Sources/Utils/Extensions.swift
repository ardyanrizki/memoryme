//
//  Extensions.swift
//  MC2
//
//  Created by Muhammad Rizki Ardyan on 26/06/23.
//

import Foundation

// MARK: CGPoint
extension CGPoint {
    static func + (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }
    static func += (point1: inout CGPoint, point2: CGPoint) {
        point1 = point1 + point2
    }
    static func - (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
    }
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    static func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
        return point * scalar
    }
    
    func normalized() -> CGPoint {
        let length = sqrt(x * x + y * y)
        if length != 0.0 {
            return CGPoint(x: x / length, y: y / length)
        } else {
            return CGPoint.zero
        }
    }
    func length() -> CGFloat {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
}

// MARK: Double
extension Double {
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}

// MARK: CGFloat
extension CGFloat {
    func toDegrees() -> Double {
        return self / .pi * 180.0
    }
    func toRadians() -> Double {
        return self * .pi / 180.0
    }
}

// MARK: String
extension String {
    static let emptyString = ""
    
    // Error text
    static let initCoderNotImplemented = "init(coder:) has not been implemented"
    static let errorNodeNotFound = "error: node not found"
    static let errorTextureNotFound = "error: texture not found"
    static let errorIdentifierNotFound = "error: identifier not found"
    static let errorPhysicsBodyNotFound = "error: physics body not found"
    
    func splitIdentifer(with separator: String = "_") -> [String] {
        return self.components(separatedBy: separator)
    }
}
