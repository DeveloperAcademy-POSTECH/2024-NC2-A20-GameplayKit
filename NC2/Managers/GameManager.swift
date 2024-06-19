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

// 게임이 진행 중일 때의 상태 클래스
class PlayingState: GKState {
    private let gameTimeComponent: GameTimeComponent
    
    init(gameTimeComponent: GameTimeComponent) {
        self.gameTimeComponent = gameTimeComponent
        super.init()
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        gameTimeComponent.update(deltaTime: seconds)
    }
}

// 게임이 일시중지된 상태 클래스
class PausedState: GKState {
    private weak var gameStateManager: GameStateManager?
    
    init(gameStateManager: GameStateManager? = nil) {
           self.gameStateManager = gameStateManager
           super.init()
       }
    
    // 상태에 진입할 때 호출되는 메서드
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        // 게임을 일시중지할 때 필요한 작업을 수행
        print("Game is now paused.")
    }
    
    // 상태에서 나올 때 호출되는 메서드
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        // 게임이 다시 진행될 때 필요한 작업을 수행
        print("Game is resuming from pause.")
    }
    
    // 일시중지 상태에서는 업데이트 로직을 수행하지 않음
    override func update(deltaTime seconds: TimeInterval) {
        // 게임이 일시중지된 상태에서는 아무런 업데이트도 하지 않음
    }
    
    // 필요에 따라 상태 전환을 허용하는지 여부를 결정하는 메서드
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        // PlayingState로만 전환을 허용
        return stateClass is PlayingState.Type
    }
}


// 게임 상태를 관리하는 클래스
class GameStateManager: ObservableObject {
    private let stateMachine: GKStateMachine
    private let gameTimeComponent = GameTimeComponent()
    
    @Published private(set) var elapsedTime: TimeInterval = 0
//    @Published private(set) var isPaused: Bool = true
    @Published var isPaused: Bool = true
    
    var currentState: GKState? {
        stateMachine.currentState
    }
    
    init() {
        stateMachine = GKStateMachine(states: [
            PlayingState(gameTimeComponent: gameTimeComponent),
            PausedState()
        ])
        
        stateMachine.enter(PlayingState.self) // 초기 상태를 PlayingState로 설정
    }
    
    func update(deltaTime seconds: TimeInterval) {
        stateMachine.update(deltaTime: seconds)
        elapsedTime = gameTimeComponent.elapsedTime
        isPaused = currentState is PausedState
    }
    
    func play() {
        stateMachine.enter(PlayingState.self)
        isPaused = false
        print("Game started")
    }
    
    func pause() {
        stateMachine.enter(PausedState.self)
        isPaused = true
        print("Game paused")
    }
}
