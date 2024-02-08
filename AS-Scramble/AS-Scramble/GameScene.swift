//
//  GameScene.swift
//  AS-Scramble
//
//  Created by user248197 on 2/5/24.
//

import SpriteKit
import GameplayKit

// TODO Collision
// Montagnes
// Bullet
// dans update if dépasse gauche enemy get pos in lobby

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var spaceCraft : SKSpriteNode?
    
    private var enemies = [Enemy]()
    
    func posIntersectsEnemy(_ pos: CGPoint) -> Bool {
        let rectangle = CGRect(x: pos.x, y: pos.y, width: 50, height: 50)
        
        for e in enemies {
            if e.frame.intersects(rectangle) {
                return true
            }
        }
        
        return false
    }
    
    func getPosInLobby() -> CGPoint {
        var pos = CGPoint(x: 0, y: 0)
        repeat {
            pos.x = self.size.width / 2 + CGFloat.random(in: 100...500)
            pos.y = CGFloat.random(in: -self.size.height / 4...self.size.height / 2)
        } while posIntersectsEnemy(pos)

        return pos
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        for i in 0...1 {
            self.enemies.append(Enemy())
            self.addChild(self.enemies[i])
            self.enemies[i].position = getPosInLobby()
        }
        
        self.spaceCraft = self.childNode(withName: "spaceCraft") as? SKSpriteNode
        self.spaceCraft?.color = SKColor.blue
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == 1 | 2 {
            self.removeAllChildren()
            
            let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
            gameOverLabel.text = "Game Over"
            gameOverLabel.fontSize = 40
            gameOverLabel.fontColor = SKColor.white
            gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.addChild(gameOverLabel)
        }
    }
    
    /*func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }*/
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x7D: // Down
            if !spaceCraft!.hasActions() {
                let moveAction = SKAction.moveBy(x: 0, y: -35, duration: 0)
                self.spaceCraft?.run(moveAction)
            }
            
        case 0x7E: // Up
            if !spaceCraft!.hasActions() && (spaceCraft!.position.y + spaceCraft!.size.height / 2 < self.size.height / 2 - 50) {
                let moveAction = SKAction.moveBy(x: 0, y: 35, duration: 0)
                self.spaceCraft?.run(moveAction)
            }
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for e in enemies {
            if e.position.x < -self.size.width / 2 {
                e.position = self.getPosInLobby()
            }
        }
    }
}
