//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Bullet: SKSpriteNode {
    init() {
        let size = CGSize(width: 10, height: 10)
        super.init(texture: nil, color: .white, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.velocity = CGVector(dx: 150, dy: 0)
        
        self.physicsBody?.categoryBitMask = 4
        self.physicsBody?.contactTestBitMask = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
