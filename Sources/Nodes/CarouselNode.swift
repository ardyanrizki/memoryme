//
//  CarouselNode.swift
//  Memoryme
//
//  Created by Muhammad Rizki Ardyan on 25/12/23.
//

import SpriteKit

class CarouselNode: SKNode {
    
    private var scrollSpeed: CGFloat = 50.0
    
    func setup(isReversed: Bool = false) {
        for child in children {
            child.zPosition = 40
        }
        startAutoScroll(isReversed: isReversed)
    }
    
    // Memulai otomatis scrolling
    private func startAutoScroll(isReversed: Bool) {
        let totalHeight = calculateAccumulatedFrame().size.height
        
        // Tentukan jarak yang akan di-scroll, sesuaikan dengan tinggi total carouselNode
        let scrollDistance = totalHeight / 2
        
        // Hitung durasi scrolling berdasarkan jarak dan kecepatan yang diinginkan
        let scrollDuration = TimeInterval(scrollDistance / 100.0) // Ubah 100.0 dengan kecepatan yang diinginkan
        
        // Buat action untuk scrolling
        var scrollAction = SKAction.moveBy(x: 0, y: -scrollDistance, duration: scrollDuration)
        
        if isReversed {
            scrollAction = SKAction.moveBy(x: 0, y: scrollDistance, duration: scrollDuration)
        }
        
        // Buat action untuk mereset posisi ke awal setelah selesai scrolling
        var resetAction = SKAction.moveBy(x: 0, y: scrollDistance, duration: 0)
        
        if isReversed {
            resetAction = SKAction.moveBy(x: 0, y: -scrollDistance, duration: 0)
        }
        
        // Gabungkan action scrolling dan reset
        let sequenceAction = SKAction.sequence([scrollAction, resetAction])
        
        // Buat action yang berulang-ulang dengan action sequence
        let repeatScrollAction = SKAction.repeatForever(sequenceAction)
        
        // Jalankan action pada scrollingNode
        run(repeatScrollAction)
    }
    
    // Menghentikan otomatis scrolling
    private func stopAutoScroll() {
        removeAllActions()
    }
    
    // Menghentikan otomatis scrolling ketika scene di-deinit
    deinit {
        stopAutoScroll()
    }
}
