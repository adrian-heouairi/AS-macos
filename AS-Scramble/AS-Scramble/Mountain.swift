//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//


import SpriteKit

class Mountain: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.MOUNTAIN_WIDTH, height: CGFloat.random(in: 0.0...768 / 4))
        super.init(texture: SKTexture(imageNamed: "mountain"), color: .black, size: size)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.mass = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.friction = 0
        self.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        
        self.physicsBody?.categoryBitMask = 8
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
