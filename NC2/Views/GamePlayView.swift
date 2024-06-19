import SwiftUI
import AVFoundation

struct GamePlayView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    
    @State private var timer: Timer?
    @State private var counter = 0
    @State private var isRunning = false
    
    @Binding var isplaying : Bool
    @Binding var mute : Bool
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var santaPosY: CGFloat = 0
    @State var colliderHit = false
    
    var body: some View {
        ZStack(){
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let imageSize = min(width, height)
                
                ZStack {
                    BackgroundView(timer: $timer)
                    SnowingView()
                        .opacity(0.8)
                    Image("ground")
                        .resizable()
                        .frame(width: imageSize * 6.5, height: imageSize * 6.5)
                        .position(x: width / 2, y: height * 3.1 )
                }
                .onTapGesture {
                    if !mute {
                        SoundManager.shared.playSound()
                    }
                    
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
                    PlayerView(santaPosY: $santaPosY, timer: $timer)
                        .padding(EdgeInsets(top: 0, leading: 60, bottom: 6, trailing: 0))
                    
                    Spacer()
                    EnemyView(timer: $timer)
                        .padding(.trailing, 62)
                }
                .padding(.bottom, 45)
                
            }
            ObstacleView(timer: $timer, colliderHit: $colliderHit)
            
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
                            .foregroundColor(Color(red: 0.85, green: 0.91, blue: 0.94))
                        //                        Text("\(timer?.timeInterval ?? 0)")
                        Text("\(gameStateManager.elapsedTime, specifier: "%.f")")
                            .foregroundStyle(.white)
                            .font(.custom("UpheavalPro", size: 42))
                            .foregroundColor(Color(red: 0.85, green: 0.91, blue: 0.94))
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
            if gameStateManager.isPaused == true {
                Color(red: 0, green: 0, blue: 0.07).opacity(0.6)
                VStack(spacing: 30){
                    Button(action: {
                        gameStateManager.isPaused = false
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
                        isplaying = false
                        gameStateManager.isPaused = false
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
                        gameStateManager.isPaused.toggle()
                        
                        if gameStateManager.isPaused == false {
                            gameStateManager.play()
                        } else {
                            gameStateManager.pause()
                        }
                        
                    }, label: {
                        if gameStateManager.isPaused == false {
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
                        BackgroundSound(mute: $mute)
                            .padding(.leading, 14)
                            .padding(.top, 15)
                    })
                    Spacer()
                }
                .padding(.leading, 51)
                .padding(.top, 25)
                Spacer()
            }
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
                let deltaTime = 1.0 / 60.0
                gameStateManager.update(deltaTime: deltaTime)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    GamePlayView(isplaying: .constant(false), mute: .constant(false))
}
