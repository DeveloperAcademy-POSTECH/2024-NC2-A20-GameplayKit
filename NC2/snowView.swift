import SwiftUI

public struct snowView: View {
    public var body: some View {
        particleSnow()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct particleSnow: View {
    @State private var particleItems: [particleItem] = []
    private let numberofparticle = 1
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            ForEach(particleItems) { item in
                item.view
            }
            VStack{}
                .onAppear{
                    startTimer()
                }
//                .onDisappear {
//                    stopTimer()
//                }
        }
        .ignoresSafeArea()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            addParticles()
        }
    }
    
//    private func stopTimer() {
//        timer?.invalidate()
//        timer = nil
//    }
    
    private func addParticles() {
        for _ in 0...(numberofparticle - 1) {
            addParticleItem()
        }
    }
    
    private func addParticleItem() {
        particleItems.append(.init(view: particleShape()))
    }
}

fileprivate struct particleItem: Identifiable {
    var id = UUID()
    var view: particleShape
}

fileprivate struct particleShape: View {
    @State private var xcoordinate = Double.random(in: -0.2...1.2)
    @State private var ycoordinate = -0.3
    private var accelate = Double.random(in: 3...5)
    private var durationtime = 20
    private var snowSize = Double.random(in: 4...8)
    
    var body: some View {
        GeometryReader { proxy in
            Ellipse()
                .foregroundColor(Color(red: 0.51, green: 0.63, blue: 0.71))
                .frame(width: snowSize, height: snowSize)
                .modifier(RainAnimation(proxy: proxy, xcoordinate: xcoordinate, ycoordinate: ycoordinate))
                .onAppear {
                    withAnimation(
                        .linear(duration: TimeInterval(durationtime))
                    ) {
                        ycoordinate += accelate
                    }
                }
        }
    }
}

fileprivate struct RainAnimation: Animatable, ViewModifier {
    let proxy: GeometryProxy
    var xcoordinate: Double
    var ycoordinate: Double
    
    private var xtrans: Double {
        return xcoordinate
    }
    
    private var ytrans: Double {
        return ycoordinate
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: proxy.size.width * xtrans,
                    y: proxy.size.height * ytrans)
    }
}

#Preview {
    snowView()
}
