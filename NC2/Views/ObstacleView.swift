import SwiftUI

struct ObstacleView: View {
    @Binding var timer: Timer?
    
    @State var degreesRotating = 0.0
    
    @Binding var colliderHit: Bool
        
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack {
                ForEach(0..<4, id:\.self) { _ in
                    Image("horn1")
                        .resizable()
                        .frame(width: 15, height: 1000)
                        .background(Color.black)
                        .rotationEffect(.degrees(degreesRotating), anchor: .bottomLeading)
                        .position(x: width / 2, y: height * 1.85)
                        .onAppear {
                            startMove()
                        }
                }
            }
//            .onAppear {
////                startUpdatingObject() // 뷰가 나타날 때 객체 업데이트 시작
//                startMove()
//            }
//            .onDisappear {
////                stopUpdatingObject() // 뷰가 사라질 때 객체 업데이트 중지
////                stopMove()
//            }
        }
    }
    
//    func startUpdatingObject() {
//        stopUpdatingObject() // 기존 타이머 중지
//        
        // 1초마다 새로운 객체를 생성하여 상태를 업데이트하는 타이머 시작
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            updateObjectWithRandomDelay()
//        }
//    }
    
//    func stopUpdatingObject() {
//        timer?.invalidate() // 타이머 무효화
//        timer = nil // 타이머 변수 초기화
//    }
    
    private func startMove() {
        withAnimation(Animation.linear(duration: 1)
            .speed(0.05).repeatForever(autoreverses: false)) {
                degreesRotating = -360.0
                
                
                //                if degreesRotating < -45.0 {
                //                    degreesRotating = 0.0 // x 좌표가 특정 값보다 작아지면 초기 위치로 재설정
                //                }
            }
    }
    
    private func stopMove() {
        degreesRotating = 0.0 // 애니메이션 정지
    }
    
    func updateObjectWithRandomDelay() {
        let randomDelay = Double.random(in: 1...5) // 1초에서 5초 사이의 랜덤 지연 시간 생성
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
            // 지연 후 새로운 객체 생성 및 상태 업데이트
//            self.currentObject = MyObject(name: "horn1")
            print("Updated object after \(randomDelay)s delay") // 콘솔에 지연 시간 출력
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
            
            ObstacleView(timer: .constant(nil), colliderHit: .constant(false))
        }
    }
}
