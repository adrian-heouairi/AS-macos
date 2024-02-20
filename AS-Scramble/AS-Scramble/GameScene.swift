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
        gameOverLabel.fontSize = 120
        gameOverLabel.fontColor = SKColor.white
        //gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(gameOverLabel)
    }
    
    func posIntersectsEnemy(_ pos: CGPoint) -> Bool {
        let rectangle = CGRect(x: pos.x, y: pos.y, width: CGFloat(Constants.ENEMY_WIDTH * 2), height: CGFloat(Constants.ENEMY_HEIGHT * 2))
        
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
            pos.x = CGFloat.random(in: Constants.LOBBY_X_START...Constants.LOBBY_X_END)
            pos.y = CGFloat.random(in: Constants.LOBBY_Y_START...Constants.LOBBY_Y_END)
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
        //self.scaleMode = .resizeFill
        
        scoreLabel.text = "Score: \(self.score)"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2 - 125, y: self.size.height / 2 - 50)
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
            mountain.position = CGPoint(x: CGFloat(xStart + i * Int(Constants.MOUNTAIN_WIDTH)), y: CGFloat(-1 * self.size.height / 2 + mountain.size.height / 2))
            self.mountains.append(mountain)
            self.addChild(mountain)
        }
        
        for _ in 1...Constants.ENEMIES_NB {
            self.addEnemy()
        }
        
        self.spaceCraft.position = CGPoint(x: -self.size.width / 2 + 100, y: self.size.height / 2 - 100)
        self.addChild(self.spaceCraft)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == nil || contact.bodyB.node == nil {
            return
        }
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == Constants.SPACECRAFT_CATEGORY | Constants.ENEMY_CATEGORY {
            self.launchGameOver()
        } else if collision == Constants.ENEMY_CATEGORY | Constants.BULLET_CATEGORY {
            self.incrementScore()
            
            let bullet: SKNode
            let enemy: SKNode
            if contact.bodyA.categoryBitMask == Constants.ENEMY_CATEGORY {
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
        } else if collision == Constants.SPACECRAFT_CATEGORY | Constants.MOUNTAIN_CATEGORY {
            self.launchGameOver()
        } else if collision == Constants.BULLET_CATEGORY | Constants.MOUNTAIN_CATEGORY {
            let bullet: Bullet
            if contact.bodyA.categoryBitMask == Constants.BULLET_CATEGORY {
                bullet = contact.bodyA.node as! Bullet
            } else {
                bullet = contact.bodyB.node as! Bullet
            }
            
            self.bullets.remove(at: self.bullets.firstIndex(of: bullet)!)
            bullet.removeFromParent()
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case Constants.KeyCodes.DOWN.rawValue:
            if !spaceCraft.hasActions() {
                let moveAction = SKAction.moveBy(x: 0, y: -Constants.SPACECRAFT_MOVE_BY, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case Constants.KeyCodes.UP.rawValue:
            if !spaceCraft.hasActions() && (spaceCraft.position.y < self.size.height / 2 - 50 - spaceCraft.size.height / 2) {
                let moveAction = SKAction.moveBy(x: 0, y: Constants.SPACECRAFT_MOVE_BY, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case Constants.KeyCodes.LEFT.rawValue:
            if !spaceCraft.hasActions() && (spaceCraft.position.x > -self.size.width / 2 + 100) {
                let moveAction = SKAction.moveBy(x: -Constants.SPACECRAFT_MOVE_BY, y: 0, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case Constants.KeyCodes.RIGHT.rawValue:
            if !spaceCraft.hasActions() && (spaceCraft.position.x < self.size.width / 2 - self.spaceCraft.size.width - 50) {
                let moveAction = SKAction.moveBy(x: Constants.SPACECRAFT_MOVE_BY, y: 0, duration: 0)
                self.spaceCraft.run(moveAction)
            }
            
        case Constants.KeyCodes.SPACE.rawValue:
            if !self.gameOver && self.bullets.count < 2 {
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
        
        let xStart = CGFloat(-1 * Int(Constants.MOUNTAIN_WIDTH) * Constants.REAL_NB_MOUNTAINS / 2)
        for m in mountains {
            if m.position.x < xStart {
                self.mountains.remove(at: self.mountains.firstIndex(of: m)!)
                m.removeFromParent()
                
                let newMountain = Mountain()
                newMountain.position = CGPoint(x: -xStart + Constants.MOUNTAIN_WIDTH, y: CGFloat(-1 * self.size.height / 2 + newMountain.size.height / 2))
                self.mountains.append(newMountain)
                self.addChild(newMountain)
            }
        }
    }
}
