import SwiftUI

struct ObstacleView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    @State private var timer: Timer?
    
    @State private var degreesRotating: [Double] = (0..<15).map { _ in Double.random(in: 0...360) }
    
    @Binding var colliderHit: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                ForEach(0..<degreesRotating.count, id: \.self) { index in
                    Image("horn1")
                        .resizable()
                        .frame(width: 15, height: 1000)
                        .rotationEffect(.degrees(degreesRotating[index]), anchor: .bottomLeading)
                        .position(x: width / 2, y: height * 1.85)
                }
            }
            .onAppear {
                if !gameStateManager.isPaused {
                    startMove()
                }
            }
        }
    }
    
    private func startMove() {
        if !gameStateManager.isPaused {
            for index in degreesRotating.indices {
                withAnimation(Animation.linear(duration: 30).repeatForever(autoreverses: false)) {
                    degreesRotating[index] = -360.0
                }
            }
        }
    }
}

#Preview {
    GeometryReader { geometry in
        let width = geometry.size.width
        let height = geometry.size.height
        let imageSize = min(width, height)
        ZStack {
            Color(red: 0, green: 0.13, blue: 0.29).ignoresSafeArea()
            Image("ground")
                .resizable()
                .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                .position(x: width / 2, y: height * 3.1 )
            
            ObstacleView(colliderHit: .constant(false)).environmentObject(GameStateManager())
        }
    }
}
