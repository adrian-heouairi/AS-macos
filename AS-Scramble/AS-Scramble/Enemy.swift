//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Enemy: SKSpriteNode {
    init() {
        let size = CGSize(width: 50, height: 50)
        super.init(texture: nil, color: .red, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        
        // Set category, collision, and contact masks
        self.physicsBody?.categoryBitMask = 2 // Example value, adjust as needed
        self.physicsBody?.collisionBitMask = 1 // Example value, adjust as needed
        self.physicsBody?.contactTestBitMask = 1 // Example value, adjust as needed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
