//
//  GameScene.swift
//  AS-Scramble
//
//  Created by user248197 on 2/5/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var spaceCraft = SpaceCraft()
    
    private var enemies = [Enemy]()
    
    private var bullets = [Bullet]()
    
    private var mountains = [Mountain]()
    
    private var gameOver = false
    
    private var score = 0
    private var scoreLabel = SKLabelNode()
    
    func launchGameOver() {
        self.gameOver = true
        self.removeAllChildren()
        let gameOverLabel = SKLabelNode()
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 80
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(gameOverLabel)
    }
    
    func posIntersectsEnemy(_ pos: CGPoint) -> Bool {
        let rectangle = CGRect(x: pos.x, y: pos.y, width: 300, height: 300)
        
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
            pos.y = CGFloat.random(in: -self.size.height / 4 + 100...self.size.height / 2 - 100)
        } while posIntersectsEnemy(pos)
        
        return pos
    }
    
    func addEnemy() {
        let enemy = Enemy()
        enemy.position = self.getPosInLobby()
        self.enemies.append(enemy)
        self.addChild(enemy)
    }
    
    func incrementScore() {
        self.score += 1
        self.scoreLabel.text = "Score: \(self.score)"
    }
    
    override func didMove(to view: SKView) {
        scoreLabel.text = "Score: \(self.score)"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2 - 150, y: self.size.height / 2 - 100)
        scoreLabel.zPosition = 0
        self.addChild(scoreLabel)
        
        let backgroundImage = SKSpriteNode(imageNamed: "space")
        backgroundImage.size = self.size
        //backgroundImage.position = CGPoint(x: 0, y: 0)
        backgroundImage.zPosition = -1
        self.addChild(backgroundImage)
        //scene?.backgroundColor = .white
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0...Constants.REAL_NB_MOUNTAINS {
            let mountain = Mountain()
            let xStart = -1 * Int(Constants.MOUNTAIN_WIDTH) * Constants.REAL_NB_MOUNTAINS / 2
            mountain.position = CGPoint(x: xStart + i * Int(Constants.MOUNTAIN_WIDTH) - 50, y: -Int(self.size.height) / 2)
            self.mountains.append(mountain)
            self.addChild(mountain)
        }
        
        for _ in 0...1 {
            self.addEnemy()
        }
        
        self.spaceCraft.position = CGPoint(x: -self.size.width / 2 + 100, y: self.size.height / 2 - 100)
        self.addChild(self.spaceCraft)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == 1 | 2 {
            self.launchGameOver()
        } else if collision == 2 | 4 {
            self.incrementScore()
            
            let bullet: SKNode
            let enemy: SKNode
            if contact.bodyA.categoryBitMask == 2 {
                enemy = contact.bodyA.node!
                bullet = contact.bodyB.node!
            } else {
                enemy = contact.bodyB.node!
                bullet = contact.bodyA.node!
            }
            
            self.bullets.remove(at: self.bullets.firstIndex(of: bullet as! Bullet)!)
            bullet.removeFromParent()
            
            self.enemies.remove(at: self.enemies.firstIndex(of: enemy as! Enemy)!)
            enemy.removeFromParent()
            
            self.addEnemy()
            
            //enemy.position = self.getPosInLobby()
            //enemy.physicsBody?.velocity = CGVector(dx: -150, dy: 0)
        } else if collision == 1 | 8 {
            self.launchGameOver()
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x7D: // Down
            if !spaceCraft.hasActions() {
                let moveAction = SKAction.moveBy(x: 0, y: -35, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case 0x7E: // Up
            if !spaceCraft.hasActions() && (spaceCraft.position.y + spaceCraft.size.height / 2 < self.size.height / 2 - 50) {
                let moveAction = SKAction.moveBy(x: 0, y: 35, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case 123: // Left
            if !spaceCraft.hasActions() && (spaceCraft.position.x > -self.size.width / 2 + 100) {
                let moveAction = SKAction.moveBy(x: -35, y: 0, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case 124: // Right
            if !spaceCraft.hasActions() && (spaceCraft.position.x < self.size.width / 2 - self.spaceCraft.size.width) {
                let moveAction = SKAction.moveBy(x: 35, y: 0, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case 0x31: // Space
            if !self.gameOver && self.bullets.count < 5 {
                let bullet = Bullet()
                let bulletX = self.spaceCraft.position.x + 50
                bullet.position = CGPoint(x: bulletX, y: self.spaceCraft.position.y)
                self.bullets.append(bullet)
                self.addChild(bullet)
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
        
        for b in bullets {
            if b.position.x > self.size.width / 2 {
                self.bullets.remove(at: self.bullets.firstIndex(of: b)!)
                b.removeFromParent()
            }
        }
        
        let xStart = -1 * Int(Constants.MOUNTAIN_WIDTH) * Constants.REAL_NB_MOUNTAINS / 2
        for m in mountains {
            if Int(m.position.x) < xStart {
                m.position = CGPoint(x: -CGFloat(xStart), y: m.position.y)
            }
        }
    }
}
