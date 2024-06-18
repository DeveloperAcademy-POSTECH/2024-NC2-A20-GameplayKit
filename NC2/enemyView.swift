
import SwiftUI

struct enemyView: View {
    @State private var enemyImage = true
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(enemyImage ? "rudolph_walk" : "rudolph_run")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 100)
                .onReceive(timer) { _ in
                    // 수정 필요
                    enemyImage.toggle()
                }
        }
        
    }
}

#Preview {
    enemyView()
}

