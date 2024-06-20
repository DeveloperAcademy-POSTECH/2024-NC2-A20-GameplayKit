import SwiftUI
import GameplayKit


// 게임 시간 컴포넌트 클래스
class GameTimeComponent: GKComponent {
    private(set) var elapsedTime: TimeInterval = 0  // 경과 시간을 저장하는 변수
    
    override func update(deltaTime seconds: TimeInterval) {
        elapsedTime += seconds  // 매 프레임마다 경과 시간을 누적시킴
    }
    
    func reset() {
        elapsedTime = 0  // 경과 시간을 0으로 초기화
    }
}

// 게임 대기 중일 때의 상태 클래스
class ReadyState: GKState {
   
}

// 게임이 진행 중일 때의 상태 클래스
class PlayingState: GKState {
    private let gameTimeComponent: GameTimeComponent
    
    init(gameTimeComponent: GameTimeComponent) {
        self.gameTimeComponent = gameTimeComponent
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {  // 새로운 상태에 진입할 때 호출 + 초기화 작업을 추가할 수 있음
    startPlaying()
    }
    override func update(deltaTime seconds: TimeInterval) {  // 매 프레임마다 행동을 호출
        gameTimeComponent.update(deltaTime: seconds)
    }
    override func willExit(to nextState: GKState) {  // 다른 상태로 전환될 때 호출
    stopPlaying()
    }
    
    private func startPlaying() {
    // 게임 플레이 초기화 코드
        gameTimeComponent.reset()
    }
    private func updateGameLogic(deltaTime: TimeInterval) {
    // 게임 로직 업데이트 코드
    }
    private func stopPlaying() {
    // 게임 플레이 정리 코드
    }
}

// 게임이 일시중지된 상태 클래스
class PausedState: GKState {
    private weak var gameStateManager: GameStateManager?
    
    init(gameStateManager: GameStateManager? = nil) {
           self.gameStateManager = gameStateManager
           super.init()
       }

    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        // 게임을 일시중지할 때 필요한 작업을 수행
        print("Game is now paused.")
    }
    override func update(deltaTime seconds: TimeInterval) {   // 일시중지 상태에서는 업데이트 로직을 수행하지 않음
        // 게임이 일시중지된 상태에서는 아무런 업데이트도 하지 않음
    }
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        // 게임이 다시 진행될 때 필요한 작업을 수행
        print("Game is resuming from pause.")
    }
//    // 필요에 따라 상태 전환을 허용하는지 여부를 결정하는 메서드
//    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
//        // PlayingState로만 전환을 허용
//        return stateClass is PlayingState.Type
//    }
}

// 게임 오버일 때의 상태 클래스
class EndState: GKState {
   
}

// 게임 상태를 관리하는 클래스
class GameStateManager: ObservableObject {
    private let stateMachine: GKStateMachine
    private let gameTimeComponent = GameTimeComponent()
    
    @Published private(set) var elapsedTime: TimeInterval = 0
//    @Published private(set) var isPaused: Bool = true
    @Published var isPaused: Bool = false
    @Published var isReady: Bool = true
    @Published var isEnd: Bool = true
    
    var currentState: GKState? {
        stateMachine.currentState
    }
    
    init() {
        stateMachine = GKStateMachine(states: [
            PlayingState(gameTimeComponent: gameTimeComponent),
            PausedState(),
            ReadyState(),
            EndState()
        ])
        
        stateMachine.enter(PlayingState.self) // 초기 상태를 PlayingState로 설정
    }
    
    // pause 상태 확인 메서드
    func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
        elapsedTime = gameTimeComponent.elapsedTime
        isPaused = currentState is PausedState
    }
    
    func play() {
        stateMachine.enter(PlayingState.self)
        isPaused = false
        isReady = false
        isEnd = false
        print("Game started")
    }
    
    func pause() {
        stateMachine.enter(PausedState.self)
        isPaused = true
        print("Game paused")
    }

    func restart() {
        stateMachine.enter(ReadyState.self)
        isPaused = false
        isReady = true
        isEnd = true
        print("Game restart")
    }
    
    func end() {
        stateMachine.enter(EndState.self)
        isEnd = true
        print("Game over")
    }
}
