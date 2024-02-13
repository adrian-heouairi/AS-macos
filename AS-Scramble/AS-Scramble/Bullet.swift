//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Bullet: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.BULLET_WIDTH, height: Constants.BULLET_HEIGHT)
        super.init(texture: SKTexture(imageNamed: "bullet"), color: .black, size: size)
        self.physicsBody = Constants.initializePhBody(width: Int(size.width),
                                                      height: Int(size.height),
                                                      velocity: Constants.BULLET_VELOCITY,
                                                      categoryBitMask: UInt32(Constants.BULLET_CATEGORY),
                                                      collisionBitMask: UInt32(Constants.ENEMY_CATEGORY | Constants.MOUNTAIN_CATEGORY),
                                                      contactTestMask: UInt32(Constants.ENEMY_CATEGORY | Constants.MOUNTAIN_CATEGORY))
        
        self.zPosition = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
