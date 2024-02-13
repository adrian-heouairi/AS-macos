import SpriteKit

class Mountain: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.MOUNTAIN_WIDTH, height: CGFloat.random(in: Constants.MOUNTAIN_MIN_HEIGHT...Constants.MOUNTAIN_MAX_HEIGHT))
        super.init(texture: SKTexture(imageNamed: "mountain"), color: .black, size: size)
        //self.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        self.physicsBody = Constants.initializePhBody(width: Int(Constants.MOUNTAIN_WIDTH),
                                                      height: Int(size.height), // + 150
                                                      velocity: Constants.MOUNTAIN_VELOCITY,
                                                      categoryBitMask: UInt32(Constants.MOUNTAIN_CATEGORY),
                                                      collisionBitMask: 0,
                                                      contactTestMask: UInt32(Constants.SPACECRAFT_CATEGORY | Constants.BULLET_CATEGORY))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
