import SwiftUI
import GameplayKit
import AVFoundation

struct PlayerView: View {
    @State private var playerImage = true
    //    @State private var playerJumpImage = Image("santa_jump")
    @Binding var santaPosY: CGFloat
    
    @Binding var timer: Timer?
    @EnvironmentObject var gameStateManager: GameStateManager

    
    var body: some View {
            ZStack {
                Image(playerImage ? "santa_idle" : "santa_walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 85, height: 95)
                    .offset(y: santaPosY)
                    .onAppear {
                        if gameStateManager.isPaused == false {
                            startWalk()
                        }
                    }
                
            }
            
        .edgesIgnoringSafeArea(.all)
    }
    
    private func startWalk() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if !gameStateManager.isPaused {
                playerImage.toggle()
            }
        }
    }
}




#Preview {
    PlayerView(santaPosY: .constant(0), timer: .constant(nil))
}
