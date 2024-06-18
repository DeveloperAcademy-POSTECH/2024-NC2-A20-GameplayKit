//
//  backgroundSound.swift
//  NC2
//
//  Created by 임소연 on 6/17/24.
//

import SwiftUI
import AVFoundation

struct backgroundSound: View {
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        VStack {
        }
        .onAppear {
            playBackgroundMusic()
        }
    }
    
    func playBackgroundMusic() {
        guard let path = Bundle.main.path(forResource: "soundBackground", ofType: "mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        DispatchQueue.global(qos: .background).async { 
                    do {
                        self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                        audioPlayer?.numberOfLoops = -1
                        self.audioPlayer?.play()
                    } catch {
                        print("Error: Could not initialize AVAudioPlayer - \(error.localizedDescription)")
                    }
                }
    }
}


#Preview {
    backgroundSound()
}
