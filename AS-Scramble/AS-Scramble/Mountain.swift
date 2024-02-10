//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Mountain: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.MOUNTAIN_WIDTH, height: CGFloat.random(in: 50.0...768 / 4))
        super.init(texture: SKTexture(imageNamed: "mountain"), color: .black, size: size)
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        self.physicsBody = Constants.initializePhBody(width: Int(Constants.MOUNTAIN_WIDTH),height: Int(size.height) + 150, categoryBitMask: UInt32(Constants.MOUNTAIN_CATEGORY), collisionBitMask: UInt32(Constants.SPACESHIP_CATEGORY), contactTestMask:UInt32(Constants.SPACESHIP_CATEGORY))
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
