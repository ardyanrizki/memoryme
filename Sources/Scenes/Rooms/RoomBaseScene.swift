//
//  RoomBaseScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

<<<<<<< HEAD:Sources/Scenes/PlayableScene.swift
/// A base class for playable scenes in the game.
class PlayableScene: SKScene {
=======
class RoomBaseScene: SKScene {
>>>>>>> main:Sources/Scenes/Rooms/RoomBaseScene.swift
    
    // MARK: - Properties
    
<<<<<<< HEAD:Sources/Scenes/PlayableScene.swift
    /// The scene manager responsible for transitioning between scenes.
    weak var scenePresenter: ScenePresenter?
=======
    var audioPlayerManager: AudioPlayerManager?
    
    var touchEventsEnabled: Bool = true
>>>>>>> main:Sources/Scenes/Rooms/RoomBaseScene.swift
    
    weak var gameStateManager: GameStateManager?
    
<<<<<<< HEAD:Sources/Scenes/PlayableScene.swift
    /// The manager for handling audio playback in the scene.
    weak var audioPlayerManager: AudioPlayerManager?
=======
    /**
     Collection of wall node to define collisions.
     */
    var walls: [WallNode] = [WallNode]()
    
    /**
     Collection of zones that are responsible for triggering scene changes.
     */
    var sceneChangeZones: [SceneChangeZoneNode] = [SceneChangeZoneNode]()
    
    /**
     Collection of interactable items that are responsible for triggering some dialog.
     */
    var interactableItems: [InteractableItem] = [InteractableItem]()
    
    /**
     Player character entity.
     */
    lazy var player: Character? = {
        nil
    }()
    
    lazy var npc: Character? = {
        nil
    }()
    
    weak var gameState: GameState?
    
    /**
     Box to showing dialog or prompt.
     */
    var dialogBox: DialogBoxNode?
>>>>>>> main:Sources/Scenes/Rooms/RoomBaseScene.swift
    
    /// The protocol defining scene-blocking behavior.
    var sceneBlocker: SceneBlockerProtocol?
    
    /// The node responsible for displaying dialog boxes.
    var dialogBox: DialogBoxNode?
    
    // MARK: - Setup
    
    /// Sets up the scene with the provided scene manager and audio player manager.
    /// - Parameters:
    ///   - scenePresenter: The scene manager for transitioning between scenes.
    ///   - audioPlayerManager: The audio player manager for handling audio playback.
    func setup(scenePresenter: ScenePresenter?,
               audioPlayerManager: AudioPlayerManager?,
               gameStateManager: GameStateManager?) {
        self.scenePresenter = scenePresenter
        self.audioPlayerManager = audioPlayerManager
        self.gameStateManager = gameStateManager
        setupDialogBox()
    }
    
    // MARK: - Dialog Box
    
<<<<<<< HEAD:Sources/Scenes/PlayableScene.swift
    /// Sets up the dialog box if it has not been initialized.
    func setupDialogBox() {
=======
    /**
     Search the scene for all PositionNode.
     - Warning: Always setup positions before all nodes or entities.
     */
    private func setupPositions() {
        positions = findAllPositionNodesInScene()
    }
    
    /**
     Setup player and assign to scene.
     */
    private func setupPlayer(at position: PositionIdentifier, from positions: [PositionNode]) {
        guard player == nil else { return }
        let positionNode = positions.first { $0.identifier == position }
        let position = positionNode?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        player = FactoryMethods.createPlayer(at: position)
        if let node = player?.node {
            addChild(node)
        }
    }
    
    func setupNPC(at position: PositionIdentifier, from positions: [PositionNode]) {
        guard npc == nil else { return }
        let positionNode = positions.first { $0.identifier == position }
        let position = positionNode?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        npc = FactoryMethods.createBartender(at: position)
        if let node = npc?.node {
            addChild(node)
        }
    }
    
    /**
     Setup dialog box.
     */
    private func setupDialogBox() {
>>>>>>> main:Sources/Scenes/Rooms/RoomBaseScene.swift
        guard dialogBox == nil else { return }
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
    }
    
<<<<<<< HEAD:Sources/Scenes/PlayableScene.swift
=======
    /**
     Setup walls collision.
     - Warning: Ensure change wall's node custom class to `WallNode`.
     */
    private func setupWallsCollision() {
        walls = children.compactMap { $0 as? WallNode }
        walls.forEach { $0.setupPhysicsBody() }
    }
    
    /**
     Setup all interactable items and add to scene.
     */
    private func setupInteractableItems() {
        let itemNodes = findAllItemNodesInScene()
        interactableItems = itemNodes.map { $0.createInteractableItem(in: self, withTextureType: nil) }
    }
    
    /**
     Setup all available sceneChangeZones.
     */
    private func setupSceneChangeZones() {
        sceneChangeZones = findAllSceneChangeZoneNodesInScene()
    }
    
    /**
     Detecting player contact to perform change scene.
     */
    private func detectIntersectsAndChangeScene() {
        sceneChangeZones.forEach { zone in
            if player?.node?.intersects(zone) == true {
                zone.moveScene(with: sceneManager, sceneBlocker: sceneBlocker)
            }
        }
    }
    
    /**
     Detecting player contact with item to perform action.
     */
    private func detectIntersectsWithItem() {
        interactableItems.forEach { item in
            if let itemNode = item.node,
               player?.node?.intersects(itemNode) == true,
               let itemIdentifier = itemNode.identifier {
                if itemNode.position.y < (player?.node?.position.y)! {
                    itemNode.zPosition = 20
                } else {
                    if itemNode.zPosition > 10 {
                        itemNode.zPosition = 10
                    }
                }
                playerDidIntersect(with: itemIdentifier, node: itemNode)
            }
        }
    }
    
    private func detectContactsWithItem(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == PhysicsType.character.rawValue ||
            contact.bodyA.categoryBitMask == PhysicsType.character.rawValue) {
            
            if (contact.bodyB.categoryBitMask == PhysicsType.item.rawValue ||
                contact.bodyB.categoryBitMask == PhysicsType.item.rawValue) {
                // This code block will triggered when player contacted with another item.
                var itemNode: ItemNode?
                if contact.bodyA.categoryBitMask == PhysicsType.item.rawValue {
                    itemNode = contact.bodyA.node as? ItemNode
                } else if contact.bodyB.categoryBitMask == PhysicsType.item.rawValue {
                    itemNode = contact.bodyB.node as? ItemNode
                }
                guard let itemNode, let identifier = itemNode.identifier else { return }
                stopPlayerWhenDidContact()
                itemNode.isShowBubble = true
                playerDidContact(with: identifier, node: itemNode)
            }
            
            if (contact.bodyB.categoryBitMask == PhysicsType.wall.rawValue ||
                contact.bodyB.categoryBitMask == PhysicsType.wall.rawValue) {
                stopPlayerWhenDidContact()
            }
        }
    }
    
    func timeout(after seconds: TimeInterval, node: SKNode, completion: @escaping () -> Void) {
        let waitAction = SKAction.wait(forDuration: seconds)
        let completionAction = SKAction.run(completion)
        let sequenceAction = SKAction.sequence([waitAction, completionAction])
        node.run(sequenceAction)
    }
    
    private func stopPlayerWhenDidContact() {
        guard let component = player?.component(ofType: ControlComponent.self) as? ControlComponent else { return }
        component.stopWalking()
    }
    
    /**
     Search for all `PositionNode`s in scene.
     */
    private func findAllPositionNodesInScene() -> [PositionNode] {
        return PositionIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `SceneChangeZoneNode`s in scene.
     */
    private func findAllSceneChangeZoneNodesInScene() -> [SceneChangeZoneNode] {
        return SceneChangeZoneIdentifier.allCases.compactMap { identifier in
            identifier.getNode(from: self)
        }
    }
    
    /**
     Search for all `ItemNode`s in scene.
     */
    private func findAllItemNodesInScene() -> [ItemNode] {
        var result = [ItemNode]()
        ItemIdentifier.allCases.forEach { identifier in
            result.append(contentsOf: identifier.getAllNodes(from: self))
        }
        return result
    }
    
    // MARK: Background Music
    func playBackgroundMusic(filename: String) {
        // Stop the current background music if playing
        stopBackgroundMusic()
        
        // Get the path to the new music file
        let filePath = Bundle.main.path(forResource: filename, ofType: nil)
        if let path = filePath {
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create the audio player
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                
                // Configure the audio player settings
                audioPlayer.numberOfLoops = -1 // Loop indefinitely
                audioPlayer.volume = 0.5 // Adjust the volume as needed
                
                // Play the background music
                audioPlayer.play()
            } catch {
                // Error handling if the audio player fails to initialize
                print("Could not create audio player: \(error.localizedDescription)")
            }
        } else {
            print("Music file not found: \(filename)")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    // Example function to change the background music during gameplay
    func changeBackgroundMusic(filename: String) {
        playBackgroundMusic(filename: filename)
    }
    
    func playSoundEffect(filename: String) {
        // Stop the current background music if playing
        stopBackgroundMusic()
        
        // Get the path to the new music file
        let filePath = Bundle.main.path(forResource: filename, ofType: nil)
        if let path = filePath {
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create the audio player
                audioEffectPlayer = try AVAudioPlayer(contentsOf: url)
                
                // Configure the audio player settings
                audioEffectPlayer.numberOfLoops = 10 // Loop indefinitely
                audioEffectPlayer.volume = 1 // Adjust the volume as needed
                
                // Play the background music
                audioEffectPlayer.play()
            } catch {
                // Error handling if the audio player fails to initialize
                print("Could not create audio player: \(error.localizedDescription)")
            }
        } else {
            print("Music file not found: \(filename)")
        }
    }
    
    func stopSoundEffect() {
        audioEffectPlayer?.stop()
        audioEffectPlayer = nil
    }
    
    // Example function to change the background music during gameplay
    func changeSoundEffect(filename: String) {
        playSoundEffect(filename: filename)
    }
    
    // MARK: Overrideable Methods
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    func playerDidIntersect(with itemIdentifier: ItemIdentifier, node: ItemNode) {}
    
    func playerDidContact(with itemIdentifier: ItemIdentifier, node: ItemNode) {}
    
}

// MARK: Overrided methods.
extension RoomBaseScene {
    
    override func didMove(to view: SKView) {
        scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = calculateDeltaTime(from: currentTime)
        
        self.update(deltaTime: deltaTime)
    }
    
    func update(deltaTime: TimeInterval) {
        detectIntersectsAndChangeScene()
        detectIntersectsWithItem()
        
        guard let controlComponent = player?.component(ofType: ControlComponent.self) as? ControlComponent else { return }
        
        controlComponent.update(deltaTime: deltaTime)
    }
    
    private func calculateDeltaTime(from currentTime: TimeInterval) -> TimeInterval {
        if timeOnLastFrame.isZero { timeOnLastFrame = currentTime }
        let deltaTime = currentTime - timeOnLastFrame
        timeOnLastFrame = currentTime
        return deltaTime
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        dialogBox?.handleTouch(on: touchLocation)
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchLocation = touches.first?.location(in: self) else { return }
        if dialogBox?.isShowing == false, (dialogBox?.isShowing == false || dialogBox?.contains(touchLocation) == false) {
            // Assign player to walk if `dialogBox` not shown.
            player?.walk(to: touchLocation)
        }
    }
    
}

// MARK: SKPhysicsContactDelegate methods.
extension RoomBaseScene: SKPhysicsContactDelegate {

    func didBegin(_ contact: SKPhysicsContact) {
        detectContactsWithItem(contact: contact)
    }

>>>>>>> main:Sources/Scenes/Rooms/RoomBaseScene.swift
}
