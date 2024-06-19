import SwiftUI
import AVFoundation

struct BackgroundSound: View {
    @State private var audioPlayer: AVAudioPlayer?
    @Binding var mute: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                toggleSound()
            }, label: {
                if !mute {
                    Image("on")
                } else {
                    Image("off")
                }
            })
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
                audioPlayer?.numberOfLoops = -1 // 무한 반복
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
    BackgroundSound(mute: .constant(true))
}
