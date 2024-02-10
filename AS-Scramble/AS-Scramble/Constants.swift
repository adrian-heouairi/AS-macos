//
//  Enemy.swift
//  AS-Scramble
//
//  Created by user248197 on 2/7/24.
//

import Foundation
import SpriteKit

class Constants {
    public static let SCENE_WIDTH = 1024
    public static let NB_MOUNTAINS_ON_SCREEN = 10
    public static let REAL_NB_MOUNTAINS = NB_MOUNTAINS_ON_SCREEN + 2
    public static let MOUNTAIN_WIDTH = CGFloat(SCENE_WIDTH / NB_MOUNTAINS_ON_SCREEN + 30)
    
    public static let ENEMIES_NB = 5
    
    public static let ENEMY_WIDTH = 100
    public static let ENEMY_HEIGHT = 100
    public static let ENEMY_VELOCITY =  CGVector(dx: -150, dy: 0)
    
    public static let SPACESHIP_WIDTH = 100
    public static let SPACESHIP_HEIGHT = 140
    
    public static let BULLET_WIDTH = 65
    public static let BULLET_HEIGHT = 65
    
    
    enum KeyCodes:UInt16 {
        case UP =  0x7E
        case DOWN = 0x7D
        case RIGHT = 0x7C
        case LEFT = 0x7B
        case SPACE = 0x31
    }
    
    public static let SPACESHIP_CATEGORY = 1
    public static let ENEMY_CATEGORY = 2
    public static let BULLET_CATEGORY = 4
    public static let MOUNTAIN_CATEGORY = 8

    public static func initializePhBody(width phWidth:Int,height phHeight:Int, categoryBitMask:UInt32, collisionBitMask:UInt32, contactTestMask:UInt32) -> SKPhysicsBody {
        let res = SKPhysicsBody(rectangleOf: CGSize(width: phWidth, height: phHeight))
            res.affectedByGravity = false
        res.mass = 0
        res.linearDamping = 0
        res.angularDamping = 0
        res.friction = 0
        
        res.categoryBitMask = categoryBitMask
        res.collisionBitMask = collisionBitMask
        res.contactTestBitMask = contactTestMask
        return res
        
    }

}
