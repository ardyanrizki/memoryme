//
//  PhotoAlbumGameSecondScene.swift
//  Memoryme
//
//  Created by Rivan Mohammad Akbar on 01/07/23.
//

import SpriteKit
import GameplayKit

/// A scene representing the second part of the photo album game.
class PhotoAlbumGameSecondScene: PlayableScene {
    
    // MARK: - Properties
    
    // Polaroid array
    var polaroidNodes: [SKSpriteNode] = []
    
    /// Initial position of polaroids
    var initialPolaroidPosition = [String: CGPoint]()
    
    /// Target position of polaroids
    var targetPolaroidNodes = [String: SKSpriteNode]()
    
    /// Next arrow button
    var rightArrow: SKSpriteNode?
    
    /// Flag to count photos matched
    var matchedPhotoCount = 0
    
    var showCompleteDialog: Bool = false
    
    // MARK: - Scene Lifecycle
    
    override func update(_ currentTime: TimeInterval) {
        if matchedPhotoCount == 2 && !showCompleteDialog {
            Task {
                if !showCompleteDialog {
                    showCompleteDialog = true
                    await dialogBox?.start(dialog: DialogResources.bedroom3WithPhoto, from: self)
                    await timeout(after: 4)
                    scenePresenter?.presentPhotoAlbumSnapshots()
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        setupDialogBox()
        setupPolaroidNodes()
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        handleTouchBegin(touch)
    }
   
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        handleTouchMove(touch)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouchEnd(touches)
    }
    
    // MARK: - Helper Methods
    
    /// Sets up polaroid nodes and target positions.
    func setupPolaroidNodes() {
        if let parentNode = childNode(withName: Constants.polaroidNodes) {
            let childrenNodes = parentNode.children as! [SKSpriteNode]
            
            for (_, childNode) in childrenNodes.enumerated() {
                polaroidNodes.append(childNode)
                initialPolaroidPosition[childNode.name!] = childNode.position
            }
        }
        
        if let targetParentNode = childNode(withName: Constants.targetPositionNodes) {
            let childrenNodes = targetParentNode.children as! [SKSpriteNode]
            for (_, childNode) in childrenNodes.enumerated() {
                targetPolaroidNodes[childNode.name!] = childNode
            }
        }
    }
    
    /// Handles the beginning of a touch event.
    func handleTouchBegin(_ touch: UITouch) {
        let touchLocation = touch.location(in: self)
        let touchedNode = self.nodes(at: touchLocation).first
        
        for polaroidNode in polaroidNodes {
            if polaroidNode.contains(touchLocation) {
                polaroidNode.position = touchLocation
            }
        }
        
        switch touchedNode?.name {
        case Constants.backButtonName:
            scenePresenter?.presentBedroom(playerPosition: .bedroomPhotoAlbumSpot)
        default:
            break
        }
    }
    
    /// Handles the movement of a touch event.
    func handleTouchMove(_ touch: UITouch) {
        let touchLocation = touch.location(in: self)
        
        for polaroidNode in polaroidNodes {
            if polaroidNode.contains(touchLocation) {
                polaroidNode.position = touchLocation
                polaroidNode.zRotation = 0
                polaroidNode.zPosition = 2
            }
        }
    }
    
    /// Handles the end of a touch event.
    func handleTouchEnd(_ touches: Set<UITouch>) {
        guard touches.first != nil else { return }
        
        for polaroidNode in polaroidNodes {
            if let targetNode = targetPolaroidNodes[polaroidNode.name!] {
                if polaroidNode.intersects(targetNode) {
                    polaroidNode.position = targetNode.position
                    polaroidNode.zPosition = 1
                    matchedPhotoCount += 1
                    
                    if let index = polaroidNodes.firstIndex(of: polaroidNode) {
                        polaroidNodes.remove(at: index)
                    }
                } else {
                    if let initialPosition = initialPolaroidPosition[polaroidNode.name!] {
                        polaroidNode.position = initialPosition
                        polaroidNode.zPosition = 1
                    }
                }
            } else {
                if let initialPosition = initialPolaroidPosition[polaroidNode.name!] {
                    polaroidNode.position = initialPosition
                    polaroidNode.zPosition = 1
                }
            }
        }
    }
    
    /// Executes a closure after a specified time interval.
    func timeout(after seconds: TimeInterval) async {
        await withCheckedContinuation { continuation in
            let waitAction = SKAction.wait(forDuration: seconds)
            let completionAction = SKAction.run({
                continuation.resume()
            })
            let sequenceAction = SKAction.sequence([waitAction, completionAction])
            run(sequenceAction)
        }
    }
}
