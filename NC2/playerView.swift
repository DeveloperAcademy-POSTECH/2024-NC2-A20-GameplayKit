import SwiftUI
import GameplayKit
import AVFoundation

struct playerView: View {
    @State private var playerImage = true
    //    @State private var playerJumpImage = Image("santa_jump")
    @Binding var santaPosY: CGFloat
//    @State private var audioPlayer: AVAudioPlayer?
    
    @Binding var timer: Timer?
    
//    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
//        GeometryReader { geometry in
            ZStack {
//                Color.clear
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        if santaPosY <= -50 {
//                            santaPosY -= 0
//                        } else {
//                            santaPosY  -= 50
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                santaPosY += 50
//                            }
//                        }
////                        SoundManager.shared.playSound()
//                    }
                
                Image(playerImage ? "santa_idle" : "santa_walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 95)
                    .offset(y: santaPosY)
//                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + santaPosY)
//                    .onReceive(timer) { _ in
//                        // 수정필요
//                        playerImage.toggle()
//                    }
                    .onAppear {
                        startWork()
                    }
                
            }
            
//        }
        .edgesIgnoringSafeArea(.all)
    }
    private func startWork() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            playerImage.toggle()
        }
    }
}




#Preview {
    playerView(santaPosY: .constant(0), timer: .constant(nil))
}
