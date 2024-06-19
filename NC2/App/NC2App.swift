//
//  NC2App.swift
//  NC2
//
//  Created by 임소연 on 6/17/24.
//

import SwiftUI

@main
struct NC2App: App {
//    @State var gameManager: GameManager = .init()
    @StateObject var gameStateManager: GameStateManager = GameStateManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
//                .environment(gameManager)
                .environmentObject(gameStateManager)
        }
    }
}

//@Observable
//class GameManager {
//    var pause: Bool = false
//}
