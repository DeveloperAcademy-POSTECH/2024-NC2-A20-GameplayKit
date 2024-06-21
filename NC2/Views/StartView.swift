//
//  StartView.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

import SwiftUI

struct StartView: View {
//    @Binding var isplaying: Bool
    @Binding var mute : Bool

    @EnvironmentObject var gameStateManager: GameStateManager

    @State private var isBlinking = false
    
    @State private var timer: Timer?
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let imageSize = min(width, height)
            ZStack {
                StartBackgroundSound(mute: $mute)
                BackgroundView(timer: $timer)
                SnowingView()
                    .opacity(0.8)
                Image("ground")
                    .resizable()
                    .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                    .position(x: width / 1.73, y: height * 3.14 )
                
                VStack(spacing: 0){
                    Text("best")
                        .foregroundStyle(.white)
                        .font(.custom("UpheavalPro", size: 16))
                        .padding(.bottom, 7)
                        .foregroundColor(Color(red: 0.85, green: 0.91, blue: 0.94))
                        .padding(.top, 37)
                    // 최고점수 받아오기
                    Text("127")
                        .foregroundStyle(.white)
                        .font(.custom("UpheavalPro", size: 42))
                        .foregroundColor(Color(red: 0.85, green: 0.91, blue: 0.94))
                        .padding(.bottom, 50)
                    Image("appLogo")
                        .padding(.bottom, 76)
                    Image("startTypo")
                        .opacity(isBlinking ? 0 : 1) // 깜빡임 효과를 위해 투명도 조절
                        .onAppear {
                            startBlinking()
                        }
                        .onDisappear {
                            stopBlinking()
                        }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .onTapGesture {
                gameStateManager.play()
            }
        }
    }
    func startBlinking() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                isBlinking.toggle()
            }
        }
    }

    func stopBlinking() {
        timer?.invalidate()
        timer = nil
        isBlinking = false // 뷰가 사라질 때 깜빡임을 멈추고 이미지가 보이도록 설정
    }
}

#Preview {
    StartView(mute: .constant(false))
}
