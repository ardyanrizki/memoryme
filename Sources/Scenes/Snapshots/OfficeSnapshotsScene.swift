//
//  OfficeSnapshotsScene.swift
//  Memoryme
//
//  Created by Ivan on 01/07/23.
//

import Foundation
import GameplayKit


class OfficeSnapshotsScene: SKScene {
    
    weak var sceneManager: SceneManagerProtocol?
    
    weak var gameState: GameState?
    
    var memoryNodes: [SKSpriteNode]!
    
    /** tap contnue label node */
    var tapContinueLabel: SKLabelNode!
    
    /** Track current snapshot that already seen */
    var currentSnapshotIndex: Int = 0
    
    var touchEventsEnabled: Bool = false
    
    let fadeDuration: TimeInterval = 1.0
    
    let delayDuration: TimeInterval = 2.0
    
    weak var gameViewController: GameViewController?
    var phoneSFX = SoundComponent(soundFile: Constants.phone)
    var cutSceneOffice = SoundComponent(soundFile: Constants.cutSceneOffice)
    
    /**Stop any background music**/
    func stopBackgroundMusic() {
        gameViewController?.stopBackgroundMusic()
    }
    
    var dialogBox: DialogBoxNode?
    
    /** show snapshot and its tap continue */
    func animateShowingSnapshot(for node: SKSpriteNode, isShowTapContinue: Bool = true) {
        let delayedTapContinueDuration = delayDuration + 2
        let fadeInAction = SKAction.fadeIn(withDuration: fadeDuration)
        _ = SKAction.run { self.touchEventsEnabled = true }
        
        let snapshotSequence = SKAction.sequence([
            SKAction.wait(forDuration: delayDuration),
            fadeInAction
        ])
        
        //Smooth transition
//        stopBackgroundMusic()
        
        node.run(snapshotSequence){
            //Cut off sound
            self.stopBackgroundMusic()
            
            //To play audio
            self.cutSceneOffice.soundPlayer?.play()
            
            if self.currentSnapshotIndex == self.memoryNodes.count - 1{
                self.phoneSFX.soundPlayer?.play()
                self.phoneSFX.soundPlayer?.volume = 0.4
            }
        }
        
        
        if isShowTapContinue {
            let tapContinueSequence = SKAction.sequence([
                SKAction.wait(forDuration: delayedTapContinueDuration),
                fadeInAction,
                SKAction.run { self.touchEventsEnabled = true }
            ])
            
            tapContinueLabel.run(tapContinueSequence)
        } else {
            self.touchEventsEnabled = true
        }
    }
    
    /** hide snapshot and its tap continue */
    func animateHidingSnapshot(for node: SKSpriteNode, completion: @escaping () -> Void = {}) {
        let fadeOutAction = SKAction.fadeOut(withDuration: fadeDuration)
        let fadeOutTapAction = SKAction.group([
            fadeOutAction,
            SKAction.run {
                self.touchEventsEnabled = false
                completion()
            }
        ])
                
        node.run(fadeOutAction)
        tapContinueLabel.run(fadeOutTapAction)
    }
    
    /** Inject tap to continue label on the bottom-right of corner */
    func createTapContinueLabel() {
        tapContinueLabel = SKLabelNode(fontNamed: Constants.fontName)
        tapContinueLabel.text = "Tap to continue"
        tapContinueLabel.name = "tap-label"
        tapContinueLabel.fontSize = 40
        tapContinueLabel.fontColor = .black
        tapContinueLabel.position = CGPoint(x: frame.maxX - (40 * 4), y: frame.minY + 40)
        tapContinueLabel.zPosition = 10
        tapContinueLabel.alpha = 0
        addChild(tapContinueLabel)
    }
    
    func startMomsCallDialog(completion: @escaping () -> Void) {
        dialogBox?.startSequence(dialogs: [
            DialogResources.office_7_onphone_seq1,
            DialogResources.office_8_onphone_seq2,
            DialogResources.office_9_onphone_seq3,
            DialogResources.office_10_onphone_seq4,
            DialogResources.office_11_onphone_seq5,
            DialogResources.office_12_onphone_seq6,
            DialogResources.office_13_onphone_seq7,
            DialogResources.office_14_onphone_seq8,
            DialogResources.office_15_onphone_seq9,
            DialogResources.office_16_onphone_seq10,
            DialogResources.office_17_onphone_seq11,
            DialogResources.office_18_onphone_seq12,
            DialogResources.office_19_onphone_seq13,
            DialogResources.office_20_onphone_seq14,
            DialogResources.office_21_onphone_seq15,
            DialogResources.office_22_onphone_seq16,
            DialogResources.office_23_onphone_seq17,
            DialogResources.office_24_onphone_seq18,
            DialogResources.office_25_onphone_seq19,
            DialogResources.office_26_onphone_seq20,
            DialogResources.office_27_onphone_seq21,
            DialogResources.office_28_onphone_seq22
        ], from: self, completion: {
            completion()
        })
    }
    
    func rejectedMomsCallDialog(completion: @escaping (() -> Void)) {
        dialogBox?.start(dialog: DialogResources.office_29_rejectPhone, from: self, completion: completion)
    }
}

// MARK: Overrided methods.
extension OfficeSnapshotsScene {
        
    override func didMove(to view: SKView) {
        memoryNodes = childNode(withName: "MemoryNodes")!.children as? [SKSpriteNode]
        let size = CGSize(width: frame.width - 200, height: 150)
        dialogBox = FactoryMethods.createDialogBox(with: size, sceneFrame: frame)
        
        createTapContinueLabel()
        
        animateShowingSnapshot(for: memoryNodes[0])
        
        if let viewController = view.window?.rootViewController as? GameViewController {
                gameViewController = viewController
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {        
        guard touchEventsEnabled else { return }
        
        guard let touch = touches.first else {
            return
        }
        
        if currentSnapshotIndex < memoryNodes.count - 1 {
            let currentSnapshotNode = memoryNodes[currentSnapshotIndex]
            let nextSnapshotNode = memoryNodes[currentSnapshotIndex + 1]
            
            currentSnapshotIndex += 1
            let isLastSnapshot = currentSnapshotIndex == memoryNodes.count - 1
            
            animateHidingSnapshot(for: currentSnapshotNode) {
                self.animateShowingSnapshot(for: nextSnapshotNode, isShowTapContinue: !isLastSnapshot)
            }
        } else {
            let touchedLocation = touch.location(in: self)
            if let touchedNode = self.nodes(at: touchedLocation).first {
            
                switch(touchedNode.name) {
                case Constants.acceptNode:
                    // Doing action if accepting the phone.
                    let currentSnapshotNode = memoryNodes[currentSnapshotIndex]
                    animateHidingSnapshot(for: currentSnapshotNode) {
                        self.gameState?.setState(key: .momsCallAccepted, value: .boolValue(true))
                        
                        self.startMomsCallDialog {
                            let whiteFade = SKTransition.fade(with: .white, duration: 1)
                            self.sceneManager?.presentOfficeRoomScene(
                                playerPosition: .computerSpot,
                                transition: whiteFade
                            )
                        }
                    }
                    
                case Constants.declineNode:
                    // Doing action if decline the phone.
                    gameState?.setState(key: .momsCallAccepted, value: .boolValue(false))
                    rejectedMomsCallDialog {
                        let whiteFade = SKTransition.fade(with: .white, duration: 1)
                        self.sceneManager?.presentOfficeRoomScene(
                            playerPosition: .computerSpot,
                            transition: whiteFade
                        )
                    }
                    
                default:
                    break
                }
            }
        }
    }
}
