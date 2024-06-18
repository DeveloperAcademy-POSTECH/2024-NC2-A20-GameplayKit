
import SwiftUI

struct enemyView: View {
    @State private var enemyImage = true
    
    @Binding var timer: Timer?
    
//    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image(enemyImage ? "rudolph_walk" : "rudolph_run")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 120)
                .onAppear{
                    startWork()
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
            enemyImage.toggle()
        }
    }

}

#Preview {
    enemyView(timer:.constant(nil))
}

