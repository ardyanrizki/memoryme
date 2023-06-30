//
//  PhotoAlbumGameScene.swift
//  MC2
//
//  Created by Clarabella Lius on 28/06/23.
//

import SpriteKit
import GameplayKit

<<<<<<< HEAD:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene2.swift
class PhotoAlbumGameScene2: SKScene {
    
    var sceneManaager: SceneManagerProtocol
    
    var photoAlbumFirst: SKSpriteNode!
    
    var photoAlbumSecond: SKSpriteNode!
=======
class PhotoAlbumGameScene: SKScene {
    
    var sceneManager: SceneManagerProtocol?
>>>>>>> main:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene.swift
    
    //polaroid array
    var polaroidNodes: [SKSpriteNode] = []
    
    /** Initial position of polaroids*/
    var initialPolaroidPosition = [String: CGPoint]()
    
    /** Target position of polaroids*/
    var targetPolaroidNodes = [String: SKSpriteNode]()
    
<<<<<<< HEAD:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene2.swift
    var arrowRight: SKSpriteNode!
    var arrowLeft: SKSpriteNode!
    
    var photoAtFirstAlbum: [String] = [
        "polaroid-boyfriend",
        "polaroid-birthday",
        "polaroid-bracelet",
        "polaroid-fight"
    ]
    
    var photoAtSecondAlbum: [String] = [
        "polaroid-chocolate",
        "polaroid-friend"
    ]
=======
    /**Next arrow button**/
    var rightArrow: SKSpriteNode?
    
    //flag to count photos matched
    var matchedPhotoCount = 0
>>>>>>> main:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene.swift
    
    override func didMove(to view: SKView) {
        photoAlbumSecond = childNode(withName: "photo-album-2") as! SKSpriteNode
        
        /**Arrows**/
        arrowRight = childNode(withName: "arrowRight") as! SKSpriteNode
        arrowLeft = childNode(withName: "arrowLeft") as! SKSpriteNode
        
        /** Calls parent scene named polaroidNotes**/
        if let parentNode = childNode(withName: "polaroidNodes") {
            /**Sets the children of polaroidNodes  as SKSpriteNode**/
            let childrenNodes = parentNode.children as! [SKSpriteNode]
            
            /** Loop through polaroidNodes and makes the child nodes as enumerated **/
            for (_, childNode) in childrenNodes.enumerated() {
                
                //apppend the children of "polaroidNodes" to array
                polaroidNodes.append(childNode)
                
                //initializes the array of initial position
                initialPolaroidPosition[childNode.name!] = childNode.position
            }
        }
        
        // add dictionary. key: target child node, value: current position of the node
        /**Loop through targetPosition**/
        if let targetPhotoAlbumSecond = childNode(withName: "photo-album-2") {
            
            /**Sets the children of targetNodePosition**/
            let targetChildrenSecond = targetPhotoAlbumSecond.children as! [SKSpriteNode]
            
            for (_, childNode) in targetChildrenSecond.enumerated() {
                targetPolaroidNodes[childNode.name!] = childNode
            }
        }
        
<<<<<<< HEAD:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene2.swift
        photoAlbumFirst.alpha = 1
        photoAlbumSecond.alpha = 0
       
=======
        //Right arrow to next scene
        rightArrow = self.childNode(withName: "arrow-right") as? SKSpriteNode
        rightArrow?.isHidden = true
        
>>>>>>> main:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene.swift
    }
    
    func handleRightArrowTap(){
        photoAlbumFirst.alpha = 0
        photoAlbumSecond.alpha = 1
    
        //Hide polaroids
        sceneManaager.presentMGPhotoAlbumScene2()
        
    }
    
    func handleLeftArrowTap(){
        photoAlbumSecond.alpha = 0
        photoAlbumFirst.alpha = 1
           
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        // TODO
        // loop throuugh to the polaroidNodes
        // check whether touchLocation contain corresponding the child node
        // if yes, change the child node position to the current touchLocation
        // otherwise, do nothing
        
        for polaroidNode in polaroidNodes {
            if polaroidNode.contains(touchLocation) {
                polaroidNode.position = touchLocation
            }
        }
        
        if arrowLeft.contains(touchLocation) {
            print("tapped left")
            handleLeftArrowTap()
        }
        
        if arrowRight.contains(touchLocation) {
            print("tapped right")
            handleRightArrowTap()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO
        // loop throuugh to the polaroidNodes
        // check whether touchLocation contain corresponding the child node
        // if yes, change the child node position to the current touchLocation
        // otherwise, do nothing
        
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        for polaroidNode in polaroidNodes{
            if polaroidNode.contains(touchLocation){
                polaroidNode.position = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO
        // loop throuugh to the polaroidNodes
        
        // if any polaroidNode selected
        // check whether the polaroid node intersect with target node
        // if yes, change polaroid node to the current target node
        
        // then remove the node from polaroidNodes
        // otherwise, use initial position to assign current selected node back to the origin position
        
        guard touches.first != nil else{
            return
        }
        
        if matchedPhotoCount == 4{
            rightArrow?.isHidden = false
        }
        
       
        for polaroidNode in polaroidNodes{

            if let targetNode = targetPolaroidNodes[polaroidNode.name!]{
                
                // check whether the polaroid node intersect with target node
                if polaroidNode.intersects(targetNode){
                    
                    // if yes, change polaroid node to the current target node
                    polaroidNode.position = targetNode.position
<<<<<<< HEAD:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene2.swift
                    
                    if photoAtFirstAlbum.contains(polaroidNode.name!) {
                        //polaroidNode.name = polaroidNode.name! + "-done"
                        polaroidNode.removeFromParent()
                        photoAlbumFirst.addChild(polaroidNode)
                    } else if photoAtSecondAlbum.contains(polaroidNode.name!) {
                        // polaroidNode.name = polaroidNode.name! + "-done"
                        polaroidNode.removeFromParent()
                        photoAlbumSecond.addChild(polaroidNode)
                    }
=======
                    matchedPhotoCount += 1
>>>>>>> main:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene.swift
        
                    //remove node from polaroidNodes
                    if let index = polaroidNodes.firstIndex(of: polaroidNode) {
                        polaroidNodes.remove(at: index)
                    }
                    
                }else{
                    
                    if let initialPosition = initialPolaroidPosition[polaroidNode.name!]{
                        polaroidNode.position = initialPosition
                    }
                    
                }
            } else {
                
                if let initialPosition = initialPolaroidPosition[polaroidNode.name!]{
                    polaroidNode.position = initialPosition
                }

            }
        }

    }
<<<<<<< HEAD:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene2.swift
    
=======
>>>>>>> main:MC2/Sources/Scenes/Mini Games/PhotoAlbumGameScene.swift
}