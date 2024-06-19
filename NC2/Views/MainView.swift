//
//  MainView.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var gameStateManager: GameStateManager
    @State private var mute = false
    
    var body: some View {
        VStack {
            if gameStateManager.isPaused {
                StartView(isplaying: $gameStateManager.isPaused, mute: $mute)
            } else {
                GamePlayView(isplaying: $gameStateManager.isPaused, mute: $mute)
            }
        }
    }
    
    
}

#Preview {
    MainView().environmentObject(GameStateManager())
}
