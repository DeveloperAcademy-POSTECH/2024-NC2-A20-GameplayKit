import GameplayKit

class GameTimeComponent: GKComponent {
    private(set) var elapsedTime: TimeInterval = 0
    
    override func update(deltaTime seconds: TimeInterval) {
        elapsedTime += seconds
    }
    
    func reset() {
        elapsedTime = 0
    }
}

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

class PausedState: GKState {
    
}

class GameStateManager: ObservableObject {
    private let stateMachine: GKStateMachine
    private let gameTimeComponent = GameTimeComponent()
    
    @Published private(set) var elapsedTime: TimeInterval = 0
    
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
    }
    
    func play() {
        stateMachine.enter(PlayingState.self)
    }
    
    func pause() {
        stateMachine.enter(PausedState.self)
    }
}
