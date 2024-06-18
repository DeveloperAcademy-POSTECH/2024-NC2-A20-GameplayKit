//
//  snowingView.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

import SwiftUI
import SpriteKit

struct snowingView: View {
    var body: some View {
        SpriteView(scene: makeGameScene(), options: [.allowsTransparency])
            .ignoresSafeArea()
            .background(Color.clear)
    }

    func makeGameScene() -> SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .resizeFill
        return scene
    }
}

#Preview {
    snowingView()
}
