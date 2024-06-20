//
//  GameEndView.swift
//  NC2
//
//  Created by yoomin on 6/21/24.
//

import SwiftUI

struct GameEndView: View {
    
    @EnvironmentObject var gameStateManager: GameStateManager

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            ZStack {
                Image("Gameover&Score View")
                    .resizable()
                    .frame(width: 880, height: 414)
                    .position(x: width / 2, y: height * 0.5 )
            }
            .onTapGesture {
                gameStateManager.restart()
            }
        }
    }
}

#Preview {
    GameEndView()
}
