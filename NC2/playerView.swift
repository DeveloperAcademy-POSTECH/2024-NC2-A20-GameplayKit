import SwiftUI
import GameplayKit
import AVFoundation

struct playerView: View {
    @State private var playerImage = true
    //    @State private var playerJumpImage = Image("santa_jump")
    @State private var santaPosY: CGFloat = 0
    @State private var audioPlayer: AVAudioPlayer?
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if santaPosY <= -50 {
                            santaPosY -= 0
                        } else {
                            santaPosY  -= 50
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                santaPosY += 50
                            }
                        }
                        SoundManager.shared.playSound()
                    }
                
                Image(playerImage ? "santa_idle" : "santa_walk")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 100)
                    .offset(y: santaPosY)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + santaPosY)
                    .onReceive(timer) { _ in
                        // 수정필요
                        playerImage.toggle()
                    }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

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

#Preview {
    playerView()
}
