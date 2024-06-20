
import SwiftUI

struct EnemyView: View {
    @State private var enemyImage = true

    @EnvironmentObject var gameStateManager: GameStateManager
    @Binding var timer: Timer?
    
    
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

