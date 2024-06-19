//
//  gameScene.swift
//  NC2
//
//  Created by 임소연 on 6/18/24.
//

//import SpriteKit
//
//class GameScene: SKScene {
//    override func didMove(to view: SKView) {
//        self.backgroundColor = .clear
//        
//        view.allowsTransparency = true
//        
//        let snowEmitterNode = SKEmitterNode(fileNamed: "SnowParticle.sks")
//        snowEmitterNode?.position = CGPoint(x: size.width / 2, y: size.height)
//        snowEmitterNode?.particlePositionRange = CGVector(dx: size.width, dy: 0)
//        snowEmitterNode?.advanceSimulationTime(10)
//        snowEmitterNode?.particleBirthRate = 10
//        
//        
//        
//        self.addChild(snowEmitterNode!)
//    }
//}

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.clear
        
        if let snowEmitterNode = SKEmitterNode(fileNamed: "SnowParticle.sks") {
            snowEmitterNode.position = CGPoint(x: size.width / 2, y: size.height)
            snowEmitterNode.particlePositionRange = CGVector(dx: size.width, dy: 0)
            snowEmitterNode.particleBirthRate = 2
            snowEmitterNode.particleLifetime = 5
            self.addChild(snowEmitterNode)
            
            let increaseBirthRateAction = SKAction.sequence([
                SKAction.wait(forDuration: 0.5),
                SKAction.run { snowEmitterNode.particleBirthRate = 8 }
            ])
            self.run(increaseBirthRateAction)
        } else {
            print("Error: Could not find SnowParticle.sks file")
        }
    }
}

