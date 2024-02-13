import SpriteKit

class Enemy: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.ENEMY_WIDTH, height: Constants.ENEMY_HEIGHT)
        super.init(texture: SKTexture(imageNamed: "enemy"), color: .black, size: size)
        self.physicsBody = Constants.initializePhBody(width: Int(size.width),
                                                      height: Int(size.height),
                                                      velocity: Constants.ENEMY_VELOCITY,
                                                      categoryBitMask: UInt32(Constants.ENEMY_CATEGORY),
                                                      collisionBitMask: 0,
                                                      contactTestMask: UInt32(Constants.BULLET_CATEGORY | Constants.SPACECRAFT_CATEGORY))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
