//
//  Sound.swift
//  NC2
//
//  Created by yoomin on 6/18/24.
//

import Foundation
import SwiftUI
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        loadSound()
    }
    
    private func loadSound() {
        guard let path = Bundle.main.path(forResource: "soundJump", ofType: "mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error: Could not initialize AVAudioPlayer - \(error.localizedDescription)")
        }
    }
    
    func playSound() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }
}
