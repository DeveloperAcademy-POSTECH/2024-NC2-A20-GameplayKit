# 2024-NC2-A20-GameplayKit

## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About GameplayKit
(해당 기술에 대한 조사 내용 정리)

> **예시** <br/><br/>
_(내용 중략) <br/>
GameplayKit에서 사용할 수 있는 기술들을 알게 되었고,StateMachine을 활용하여 사용자의 입력에 따라 상태전환과 그에 따른 행동정의를 쉽게 관리할 수 있다는 것을 알게 되었다. <br/>
(내용 중략)_

## 🎯 What we focus on?
> **예시** <br/> GameplayKit에서 StateMachine를 활용하고, SpriteKit를 사용하여 2D 그래픽을 추가하고 사용하였다.
## 💼 Use Case
> **예시** <br/> 짧은 시간동안 가볍고 쉽게 즐길 수 있는 1인용 장애물 피하기 게임을 만들자!

## 🖼️ Prototype
화면을 클릭 시 게임 시작
![Group 14](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A20-GameplayKit/assets/138895117/978b6f18-6bb8-4263-96e7-ae2ff06c6b18)
플레이화면: 장애물을 탭 제스쳐로 피하는 게임
![Group 17](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A20-GameplayKit/assets/138895117/8ee34f29-a192-422e-b4cd-04727805c51e)
일시정지 버튼: 게임 속 애니메이션 중지
Continue: 게임 화면으로 돌아감
Quit Game: 초기화면으로 돌아감
![Group 19](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A20-GameplayKit/assets/138895117/78d656e5-2b06-41e2-b574-45f02aa089d0)
게임 종료: 장애물에 부딪혔을 경우 게임이 종료되고, 현재 및 최고 스코어를 확인
![Group 16](https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A20-GameplayKit/assets/138895117/2e977c94-1e6e-403a-8e5b-10848741197d)


## 🛠️ About Code
```
// 상태 관리 클래스 예제
import GameplayKit

// 게임이 진행 중일 때의 상태 클래스
class PlayingState: GKState {

override func didEnter(from previousState: GKState?) {  // 새로운 상태에 진입할 때 호출 + 초기화 작업을 추가할 수 있음
startPlaying()
}
override func update(deltaTime seconds: TimeInterval) {  // 매 프레임마다 행동을 호출
updateGameLogic(deltaTime: seconds)
}
override func willExit(to nextState: GKState) {  // 다른 상태로 전환될 때 호출
stopPlaying()
}

private func startPlaying() {
// 게임 플레이 초기화 코드
}
private func updateGameLogic(deltaTime: TimeInterval) {
// 게임 로직 업데이트 코드
}
private func stopPlaying() {
// 게임 플레이 정리 코드
} 

}
```
```
// 상태머신 설정 예제
class GameStateManager: ObservableObject {
    private let stateMachine: GKStateMachine
//pause 상태 확인 Bool
   @Published private(set) var isPaused: Bool = false 
    init() {
        stateMachine = GKStateMachine(states: [
            PlayingState(),
            PausedState(),
            EndState()
        ])
// 초기 상태를 PlayingState로 설정
        stateMachine.enter(PlayingState.self)
    }

//pause 상태 확인 메서드  
func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
        isPaused = currentState is PausedState
    }
    func play() {
        stateMachine.enter(PlayingState.self)
    }
    func pause() {
        stateMachine.enter(PausedState.self)
    }
    func end() {
        stateMachine.enter(EndState.self)
    }
```



