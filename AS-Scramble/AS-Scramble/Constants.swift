import Foundation
import SpriteKit

class Constants {
    public static let SCENE_WIDTH = 1024
    public static let SCENE_HEIGHT = 768
    
    public static let NB_MOUNTAINS_ON_SCREEN = 10
    public static let REAL_NB_MOUNTAINS = NB_MOUNTAINS_ON_SCREEN + 2
    public static let MOUNTAIN_WIDTH = CGFloat(SCENE_WIDTH / NB_MOUNTAINS_ON_SCREEN + 30)
    public static let MOUNTAIN_VELOCITY = CGVector(dx: -150, dy: 0)
    
    public static let MOUNTAIN_MIN_HEIGHT = 50.0
    public static let MOUNTAIN_MAX_HEIGHT = CGFloat(SCENE_HEIGHT / 4)
    
    // The lobby contains all positions where an enemy can appear (the center of the enemy is in the lobby, the enemy itself might have parts outside of the lobby)
    
    public static let LOBBY_X_START = CGFloat(SCENE_WIDTH / 2 + ENEMY_WIDTH / 2)
    public static let LOBBY_X_END = CGFloat(SCENE_WIDTH / 2 + ENEMY_WIDTH / 2 + 6 * ENEMY_WIDTH)
    
    public static let SPACECRAFT_MOVE_BY = CGFloat(35)
    
    private static let tmp = MOUNTAIN_MAX_HEIGHT + CGFloat(ENEMY_HEIGHT / 2)
    public static let LOBBY_Y_START = CGFloat(CGFloat(-SCENE_HEIGHT / 2) + tmp)
    public static let LOBBY_Y_END = CGFloat(SCENE_HEIGHT / 2 - ENEMY_HEIGHT / 2)
    
    public static let ENEMIES_NB = 5
    
    public static let ENEMY_WIDTH = 100
    public static let ENEMY_HEIGHT = 100
    public static let ENEMY_VELOCITY =  CGVector(dx: -150, dy: 0)
    
    public static let SPACECRAFT_WIDTH = 100
    public static let SPACECRAFT_HEIGHT = 140
    
    public static let BULLET_WIDTH = 65
    public static let BULLET_HEIGHT = 65
    public static let BULLET_VELOCITY = CGVector(dx: 300, dy: 0)
    
    
    enum KeyCodes: UInt16 {
        case UP =  0x7E
        case DOWN = 0x7D
        case RIGHT = 0x7C
        case LEFT = 0x7B
        case SPACE = 0x31
    }
    
    public static let SPACECRAFT_CATEGORY = 1
    public static let ENEMY_CATEGORY = 2
    public static let BULLET_CATEGORY = 4
    public static let MOUNTAIN_CATEGORY = 8
    
    public static func initializePhBody(width phWidth:Int, height phHeight:Int, velocity:CGVector, categoryBitMask:UInt32, collisionBitMask:UInt32, contactTestMask:UInt32) -> SKPhysicsBody {
        let res = SKPhysicsBody(rectangleOf: CGSize(width: phWidth, height: phHeight))
        res.affectedByGravity = false
        res.mass = 0
        res.linearDamping = 0
        res.angularDamping = 0
        res.friction = 0
        res.velocity = velocity
        
        res.categoryBitMask = categoryBitMask
        res.collisionBitMask = collisionBitMask
        res.contactTestBitMask = contactTestMask
        return res
    }
    
}
