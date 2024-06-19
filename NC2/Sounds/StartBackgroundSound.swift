import SwiftUI
import AVFoundation

struct StartBackgroundSound: View {
    @State private var audioPlayer: AVAudioPlayer?
    @Binding var mute: Bool
    
    var body: some View {
        VStack {
        }
        .onAppear {
            playBackgroundMusic()
        }
    }
    
    func playBackgroundMusic() {
        guard let path = Bundle.main.path(forResource: "startBackgroundSound", ofType: "mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        DispatchQueue.global(qos: .background).async {
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = 1
                self.audioPlayer?.play()
            } catch {
                print("Error: Could not initialize AVAudioPlayer - \(error.localizedDescription)")
            }
        }
    }
    
    func toggleSound() {
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
                mute = true
            } else {
                player.play()
                mute = false
            }
        }
    }
}

#Preview {
    StartBackgroundSound(mute: .constant(true))
}
