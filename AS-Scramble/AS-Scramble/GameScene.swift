//
//  GameScene.swift
//  AS-Scramble
//
//  Created by user248197 on 2/5/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var spinnyNode : SKShapeNode?
    
    private var spaceCraft : SKSpriteNode?
    
    private var enemies = [SKSpriteNode?]()
    
    override func didMove(to view: SKView) {
        
        
        self.spaceCraft = self.childNode(withName: "spaceCraft") as? SKSpriteNode
        
        self.spaceCraft?.color = SKColor.blue
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
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
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x7D: // Down
            if !spaceCraft!.hasActions() {
                let moveAction = SKAction.moveBy(x: 0, y: -35, duration: 0)
                self.spaceCraft?.run(moveAction)
            }
        
        case 0x7E: // Up
            if  !spaceCraft!.hasActions() && (spaceCraft!.position.y + spaceCraft!.size.height / 2 < self.size.height / 2 - 50) {
                let moveAction = SKAction.moveBy(x: 0, y: 35, duration: 0)
                self.spaceCraft?.run(moveAction)
            }
            
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
      
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
