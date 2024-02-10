//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Enemy: SKSpriteNode {
    init() {
        let size = CGSize(width: 100, height: 100)
        super.init(texture: SKTexture(imageNamed: "enemy"), color: .black, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        
        self.physicsBody?.categoryBitMask = 2
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 0b101
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
