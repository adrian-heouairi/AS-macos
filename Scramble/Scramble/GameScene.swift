//
//  GameScene.swift
//  Scramble
//
//  Created by Hubert Phrinfo on 26/01/2022.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var flys : SKSpriteNode?
    private var maBombe : SKSpriteNode?
    private var myScore : SKLabelNode?
    private var fired : Bool?
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.flys = self.childNode(withName: "fly") as? SKSpriteNode
        self.myScore = self.childNode(withName: "score") as? SKLabelNode
        self.flys?.texture = SKTexture(imageNamed: "space.png")
        self.maBombe = self.childNode(withName: "bombe") as? SKSpriteNode
        self.maBombe?.texture = SKTexture(imageNamed: "miss.png")
        self.fired = false
        
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
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
        print("Key code :\(event.keyCode)")
        switch event.keyCode {
            
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        case 0x7B: //left
            let moveAction = SKAction.moveBy(x: -10, y: 0, duration: 1)
            let myNode = childNode(withName: "fly")
            let myBombNode = childNode(withName: "bombe")
            myNode?.run(moveAction)
            if fired==false {
                myBombNode?.run(moveAction)
            }
        case 0x7D: //down
            let moveAction = SKAction.moveBy(x: 0, y: -10, duration: 1)
            let myNode = childNode(withName: "fly")
            let myBombNode = childNode(withName: "bombe")
            myNode?.run(moveAction)
            if fired==false {
                myBombNode?.run(moveAction)
            }
        case 0x7C: //right
            let moveAction = SKAction.moveBy(x: 10, y: 0, duration: 1)
            let myNode = childNode(withName: "fly")
            let myBombNode = childNode(withName: "bombe")
            myNode?.run(moveAction)
            if fired==false {
                myBombNode?.run(moveAction)
            }
        case 0x7E: //up
            let moveAction = SKAction.moveBy(x: 0, y: 10, duration: 1)
            let myNode = childNode(withName: "fly")
            let myBombNode = childNode(withName: "bombe")
            myNode?.run(moveAction)
            if fired==false {
                myBombNode?.run(moveAction)
            }
            
        case 0x2D: //?
            self.fired = true
            let myNode = childNode(withName: "bombe")
            let moveAction = SKAction.moveBy(x: 550, y: 0, duration: 0.5)
            myNode?.run(SKAction.unhide())
            myNode?.run(moveAction)
            
            

        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
