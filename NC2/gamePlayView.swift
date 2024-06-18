import SwiftUI
import AVFoundation

struct gamePlayView: View {
    @State private var rotate = 0.0
    @State private var timer: Timer?
    @State private var paused = false
    @State private var mute = false
    @State private var audioPlayer: AVAudioPlayer?
    
    //    @Binding var santaPosY : Int
    @State private var santaPosY: CGFloat = 0
    
    var body: some View {
        ZStack(){
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let imageSize = min(width, height)
                
                ZStack {
                    Color(red: 0, green: 0.13, blue: 0.29)
                    Image("background")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                        .rotationEffect(.degrees(rotate), anchor: .center)
                        .position(x: width / 2, y: height * 3.1 )
                    Image("moon")
                        .offset(x: 335, y: -130)
                    snowingView()
                        .opacity(0.8)
                    Image("ground")
                        .resizable()
                        .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                        .position(x: width / 2, y: height * 3.1 )
                }
                .onAppear {
                    startRotation()
                }
                .onDisappear {
                    stopRotation()
                }
                .onTapGesture {
                    SoundManager.shared.playSound()
                    
                    if santaPosY <= -50 {
                        santaPosY -= 0
                    } else {
                        santaPosY  -= 50
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            santaPosY += 50
                        }
                    }
                }
            }
            VStack(spacing: 0) {
                Spacer()
                HStack(alignment: .bottom, spacing: 0){
                    playerView(santaPosY: $santaPosY, timer: $timer)
                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 6, trailing: 0))
                        .background(Color.white)
                    
                    Spacer()
                    enemyView(timer: $timer)
                        .padding(.trailing, 62)
                        .background(Color.white)
                }
                .padding(.bottom, 45)
                
            }
            VStack(spacing: 0){
                HStack(alignment: .top, spacing: 0) {
                    Image("pause")
                        .padding(.trailing, 13)
                        .padding(.top, 15)
                        .opacity(0)
                    Image("on")
                        .padding(.leading, 14)
                        .padding(.top, 15)
                        .opacity(0)
                    VStack(spacing: 0){
                        Text("score")
                            .foregroundStyle(.white)
                            .font(.custom("UpheavalPro", size: 16))
                            .padding(.bottom, 7)
                        Text("86")
                            .foregroundStyle(.white)
                            .font(.custom("UpheavalPro", size: 42))
                    }
                    .padding(.leading, 276)
                    .padding(.trailing, 270)
                    .padding(.top, 12)
                    Ellipse()
                        .frame(width: 80, height: 83)
                        .foregroundColor(.clear)
                }
                .padding(.top, 25)
                Spacer()
            }
            if paused {
                Color(red: 0, green: 0, blue: 0.07).opacity(0.6)
                VStack(spacing: 30){
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 251, height: 42)
                                .background(Color(red: 0.4, green: 0.55, blue: 0.64))
                            Text("continue")
                                .foregroundStyle(.white)
                                .font(.custom("UpheavalPro", size: 42))
                        }
                    })
                    Button(action: {
                        
                    }, label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 251, height: 42)
                                .background(Color(red: 0.4, green: 0.55, blue: 0.64))
                            Text("quit game")
                                .foregroundStyle(.white)
                                .font(.custom("UpheavalPro", size: 42))
                        }
                    })
                }
                .padding(.top, 16)
                
                
            }
            VStack(spacing: 0){
                HStack(spacing: 0){
                    Button(action: {
                        paused.toggle()
                    }, label: {
                        if !paused {
                            Image("pause")
                                .padding(.trailing, 13)
                                .padding(.top, 15)
                        } else {
                            Image("play")
                                .padding(.trailing, 13)
                                .padding(.top, 15)
                        }
                    })
                    Button(action: {
                        mute.toggle()
                    }, label: {
                        if !mute {
                            Image("on")
                                .padding(.leading, 14)
                                .padding(.top, 15)
                        } else {
                            Image("off")
                                .padding(.leading, 14)
                                .padding(.top, 15)
                        }
                    })
                    Spacer()
                }
                .padding(.leading, 51)
                .padding(.top, 25)
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        backgroundSound()
    }
    
    
    
    
    private func startRotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            rotate -= 0.5
        }
    }
    
    private func stopRotation() {
        timer?.invalidate()
        timer = nil
    }
    
    
    
}




#Preview {
    gamePlayView()
}
