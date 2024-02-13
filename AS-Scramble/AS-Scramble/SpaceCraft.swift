import SpriteKit

class SpaceCraft: SKSpriteNode {
    init() {
        let size = CGSize(width: Constants.SPACECRAFT_WIDTH, height: Constants.SPACECRAFT_HEIGHT)
        super.init(texture: SKTexture(imageNamed: "spacecraft"), color: .black, size: size)
        self.physicsBody = Constants.initializePhBody(width: Int(size.width),
                                                      height: Int(size.height),
                                                      velocity: CGVector(dx: 0, dy: 0),
                                                      categoryBitMask: UInt32(Constants.SPACECRAFT_CATEGORY),
                                                      collisionBitMask: 0,
                                                      contactTestMask: UInt32(Constants.ENEMY_CATEGORY | Constants.MOUNTAIN_CATEGORY))
        
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
