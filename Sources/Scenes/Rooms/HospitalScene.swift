//
//  HospitalScene.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 21/06/23.
//

import SpriteKit
import GameplayKit

/// The `HospitalScene` class represents the scene for the hospital room.
class HospitalScene: RoomScene, PresentableSceneProtocol {
    
    // MARK: - Properties
    
    /// The renderable items in the hospital scene.
    override var renderableItems: [any RenderableItem] {
        [
            SharingItem.allCases as [any RenderableItem],
            HospitalItem.allCases as [any RenderableItem],
        ].flatMap { $0 }
    }
    
    /// The type of the scene.
    typealias T = HospitalScene
    
    // MARK: - Scene Initialization
    
    /// Creates and returns a shared instance of the hospital scene with the specified player position.
    static func sharedScene(playerPosition position: CharacterPosition) -> HospitalScene? {
        let scene = HospitalScene(fileNamed: Constants.hospitalScene)
        scene?.setup(playerPosition: .hospitalPlayerBed)
        return scene
    }
    
    // MARK: - Characters
    
    /// The mom character in the hospital scene.
    var mom: Character? {
        characters.first{ $0.identifier == Constants.momName }
    }
    
    /// The dad character in the hospital scene.
    var dad: Character? {
        characters.first{ $0.identifier == Constants.dadName }
    }
    
    /// The bartender character in the hospital scene.
    var bartender: Character? {
        characters.first{ $0.identifier == Constants.bartenderName }
    }
    
    /// The first friend character in the hospital scene.
    var friend1: Character? {
        characters.first{ $0.identifier == Constants.friend1Name }
    }
    
    /// The second friend character in the hospital scene.
    var friend2: Character? {
        characters.first{ $0.identifier == Constants.friend2Name }
    }
    
    // MARK: - Scene Setup
    
    /// Called when the scene is added to the view.
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        player?.disabledMovement = true
        audioPlayerManager?.stopBackgroundAudio()
        audioPlayerManager?.play(audioFile: .bedroomSnapshotsBGM, type: .soundEffect)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            Task {
                await self.startEvent()
            }
        }
    }
    
    /// Sets up the player at the specified position using the available position nodes.
    override func setupPlayer(at position: CharacterPosition, from positions: [CharacterPositionNode]) {
        let positionNode = positions.first { $0.identifier == .hospitalPlayerBed }
        let position = positionNode?.position ?? CGPoint(x: frame.midX, y: frame.midY)
        player = FactoryMethods.createColoredPlayer(at: position)
        player?.animate(for: .sleep)
        if let node = player?.node {
            addChild(node)
        }
    }
}

// MARK: - Characters Dispatch
extension HospitalScene {
    
    /// Checks if the parents are present in the hospital scene.
    var isParentsPresent: Bool {
        gameStateManager?.getState(key: .momsCallAccepted) == .boolValue(true)
    }
    
    /// Checks if the friends are present in the hospital scene.
    var isFriendsPresent: Bool {
        gameStateManager?.getState(key: .friendsPhotosKept) == .boolValue(true)
    }
    
    /// Checks if the bartender is present in the hospital scene.
    var isBartenderPresent: Bool {
        gameStateManager?.getState(key: .strangerSaved) == .boolValue(true)
    }
    
    /// Checks if any character is present in the hospital scene.
    var isAnyPresent: Bool {
        isParentsPresent || isFriendsPresent || isBartenderPresent
    }
    
    /// Checks if all characters are present in the hospital scene.
    var isAllPresent: Bool {
        isParentsPresent && isFriendsPresent && isBartenderPresent
    }
    
    /// Starts the main event sequence in the hospital scene.
    private func startEvent() async {
        if isAnyPresent {
            await enterFirstPerson()
            await playerAwake()
            await firstPersonDialog()
            await enterSecondPerson()
            await secondPersonDialog()
            await enterThirdPerson()
            await thirdPersonDialog()
            
        } else {
            await playerAwake()
            await alternativeSoloDialog()
            
        }
        try? await Task.sleep(nanoseconds: 4 * 1_000_000_000)
        
        scenePresenter?.presentEndingScreen()
    }
    
    /// Enters the first person perspective based on character presence.
    private func enterFirstPerson() async {
        if isParentsPresent {
            await enterParents()
        } else if isFriendsPresent {
            await enterFriends()
        } else if isBartenderPresent {
            await enterBartender()
        }
        
        try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
    }
    
    /// Makes the player character awake.
    private func playerAwake() async {
        try? await Task.sleep(nanoseconds: 4 * 1_000_000_000)
        player?.animate(for: .idle)
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        await soloDialog()
    }
    
    /// Enters the second person perspective based on character presence.
    private func enterSecondPerson() async {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        if isParentsPresent, isFriendsPresent {
            await enterFriends()
        } else if isBartenderPresent {
            await enterBartender()
        }
    }
    
    /// Enters the third person perspective based on character presence.
    private func enterThirdPerson() async {
        if isAllPresent {
            await enterBartender()
        }
    }
    
    /// Enters the parents characters into the scene.
    private func enterParents() async {
        let mom = assignMomToScene()
        await dispatch(character: mom, walkTo: .hospitalMomDestinationSpot)
        let dad = assignDadToScene()
        await dispatch(character: dad, walkTo: .hospitalDadDestinationSpot)
    }
    
    /// Enters the friends characters into the scene.
    private func enterFriends() async {
        let friend1 = assignFriend1ToScene()
        await dispatch(character: friend1, walkTo: .hospitalFriend1DestinationSpot)
        let friend2 = assignFriend2ToScene()
        await dispatch(character: friend2, walkTo: .hospitalFriend2DestinationSpot)
    }
    
    /// Enters the bartender character into the scene.
    private func enterBartender() async {
        let bartender = assignBartenderToScene()
        await dispatch(character: bartender, walkTo: .hospitalBartenderDestinationSpot)
    }
    
    /// Dispatches the character to the specified position.
    private func dispatch(character: Character?, walkTo position: CharacterPosition) async {
        guard let spot = childNode(withName: position.rawValue) else { return }
        await withCheckedContinuation { continuation in
            character?.walk(to: spot.position, completion: {
                continuation.resume()
            })
        }
    }
    
    /// Assigns the mom character to the scene.
    private func assignMomToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.hospitalEntrance.rawValue) else { return nil }
        let character = FactoryMethods.createColoredMom(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
    
    /// Assigns the dad character to the scene.
    private func assignDadToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.hospitalEntrance.rawValue) else { return nil }
        let character = FactoryMethods.createColoredDad(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
    
    /// Assigns the bartender character to the scene.
    private func assignBartenderToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.hospitalEntrance.rawValue) else { return nil }
        let character = FactoryMethods.createColoredBartender(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
    
    /// Assigns the first friend character to the scene.
    private func assignFriend1ToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.hospitalEntrance.rawValue) else { return nil }
        let character = FactoryMethods.createColoredFriend1(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
    
    /// Assigns the second friend character to the scene.
    private func assignFriend2ToScene() -> Character? {
        guard let entranceSpot = childNode(withName: CharacterPosition.hospitalEntrance.rawValue) else { return nil }
        let character = FactoryMethods.createColoredFriend2(at: entranceSpot.position)
        addCharacter(character)
        return character
    }
}
    
// MARK: Scene Dialogs
extension HospitalScene {
    
    /// Presents the first person dialogues.
    private func firstPersonDialog() async {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        
        if isParentsPresent {
            await parentDialogs()
        } else if isFriendsPresent {
            await friendsDialog()
        } else if isBartenderPresent {
            await bartenderDialog()
        }
    }
    
    /// Presents the second person dialogues.
    private func secondPersonDialog() async {
        if isParentsPresent, isFriendsPresent {
            await friendsDialog()
            
        } else if isBartenderPresent {
            await bartenderDialog()
        }
        
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    }
    
    /// Presents the third person dialogues.
    private func thirdPersonDialog() async {
        if isAllPresent {
            await bartenderDialog()
        }
    }
    
    /// Presents the solo dialogues.
    private func soloDialog() async {
        let dialog = DialogResources.hospital1Solo
        await dialogBox?.start(dialog: dialog, from: self)
    }
    
    /// Presents the alternative solo dialogues.
    private func alternativeSoloDialog() async {
        let dialogs = DialogResources.hospital2SoloAlt2Sequence
        await dialogBox?.start(dialogs: dialogs, from: self)
    }

    /// Presents the parent dialogues.
    private func parentDialogs() async {
        let dialogs = DialogResources.hospital2ParentSequence
        await dialogBox?.start(dialogs: dialogs, from: self)
    }

    /// Presents the friends dialogues.
    private func friendsDialog() async {
        let dialogs = DialogResources.hospital3FriendSequence
        await dialogBox?.start(dialogs: dialogs, from: self)
    }

    /// Presents the bartender dialogues.
    private func bartenderDialog() async {
        let dialogs = DialogResources.hospital4BartenderSequence
        await dialogBox?.start(dialogs: dialogs, from: self)
    }
}
