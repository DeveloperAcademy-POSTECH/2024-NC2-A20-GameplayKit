
import SwiftUI

struct EnemyView: View {
    @State private var enemyImage = true
//    @Environment(GameManager.self) private var gameManager
    @EnvironmentObject var gameStateManager: GameStateManager
    @Binding var timer: Timer?
    
//    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(enemyImage ? "rudolph_idle" : "rudolph_walk")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 120)
                .onAppear{
                    if gameStateManager.isPaused == false {
                        startWork()
                    }
                }
//                .onAppear(timer){ _ in
//                    // 수정 필요
//                    enemyImage.toggle()
//
//                }
        }
        
    }
    
    private func startWork() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            if !gameStateManager.isPaused {
                enemyImage.toggle()
            }
        }
    }

}

#Preview {
    EnemyView(timer:.constant(nil))
}

