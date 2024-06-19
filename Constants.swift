//
//  Constants.swift
//  NC2
//
//  Created by yoomin on 6/19/24.
//

import SpriteKit

let SpriteAtlas = SKTextureAtlas(named: "Sprites")

struct Layer {
    static let player: CGFloat = 3
    static let obstacle: CGFloat = 4
}

// 충돌체크가 필요한 객체들
struct PhysicsCategory {
    static let player: UInt32 = 0x1 << 0  // 1
    static let enemy: UInt32 = 0x1 << 1   // 2
}

