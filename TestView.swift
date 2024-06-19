//
//  SwiftUIView.swift
//  NC2
//
//  Created by yoomin on 6/19/24.
//

import SwiftUI

struct TestView: View {
    @State private var currentObject: MyObject? // 현재 표시할 객체를 저장하는 상태 변수
    
//    @State private var timer: Timer? // 타이머를 저장하는 상태 변수
    @Binding var timer: Timer?

    var body: some View {
        VStack {
            if let object = currentObject {
                Text(object.name) // 객체의 이름을 텍스트로 표시
                    .padding()
                    .border(Color.red, width: 1)
                    .padding()
            } else {
                Text("No Object") // 객체가 없을 때 표시할 텍스트
                    .padding()
                    .border(Color.black, width: 1)
                    .padding()
            }
        }
        .onAppear {
            startUpdatingObject() // 뷰가 나타날 때 객체 업데이트 시작
        }
        .onDisappear {
            stopUpdatingObject() // 뷰가 사라질 때 객체 업데이트 중지
        }
    }

    func startUpdatingObject() {
        stopUpdatingObject() // 기존 타이머 중지
        
        // 1초마다 새로운 객체를 생성하여 상태를 업데이트하는 타이머 시작
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateObjectWithRandomDelay()
        }
    }

    func stopUpdatingObject() {
        timer?.invalidate() // 타이머 무효화
        timer = nil // 타이머 변수 초기화
    }

    func updateObjectWithRandomDelay() {
        let randomDelay = Double.random(in: 1...5) // 1초에서 5초 사이의 랜덤 지연 시간 생성
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) {
            // 지연 후 새로운 객체 생성 및 상태 업데이트
            self.currentObject = MyObject(name: "Item updated at \(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium))")
            print("Updated object after \(randomDelay)s delay") // 콘솔에 지연 시간 출력
        }
    }
}

struct MyObject {
    let name: String // 객체의 이름을 저장하는 속성
}



#Preview {
    TestView(timer: .constant(nil))
}
