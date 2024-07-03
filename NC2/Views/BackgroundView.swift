//
//  backgroundView.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    @State private var rotate = 0.0
    @Binding var timer : Timer?
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let imageSize = min(width, height)
            ZStack{
                Color(red: 0, green: 0.13, blue: 0.29)
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                    .rotationEffect(.degrees(rotate), anchor: .center)
                    .position(x: width / 2, y: height * 3.1 )
                Image("moon")
                    .offset(x: 335, y: -130)
            }
            .onAppear {
                startRotation()
            }
            .onDisappear {
                stopRotation()
            }
        }
    }
    
    private func startRotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !gameStateManager.isPaused {
                rotate -= 0.5
            }
        }
    }
    
    private func stopRotation() {
        timer?.invalidate()
        timer = nil
    }
    
    
    
}


#Preview {
    BackgroundView(timer: .constant(nil))
}
