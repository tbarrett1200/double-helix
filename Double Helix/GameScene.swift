//
//  GameScene.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/20/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
    var b1: SKShapeNode!
    var b2: SKShapeNode!
    var b3: SKShapeNode!
    var b4: SKShapeNode!

    override func didMove(to view: SKView) {
        let screenWidth = Int(self.frame.size.width)
        let nodeWidth = 100
        let numNodes = screenWidth/nodeWidth + 2
    
        
        let bottom = Polynucleotide(size: numNodes, top: false)
        bottom.position = CGPoint(x: -self.frame.size.width/2, y: 30)
        let moveBottom = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 1)
        let addBottom = SKAction.run{ bottom.addBack() }
        let actionBottom = SKAction.repeatForever(SKAction.sequence([moveBottom, addBottom]))
        bottom.run(actionBottom)
        addChild(bottom)
        
        b1 = SKShapeNode(circleOfRadius: 40)
        b1.fillColor = Nucleobase.adenine.color()
        b1.strokeColor = b1.fillColor
        b1.position = CGPoint(x: -self.frame.width/2 + 60, y: -self.frame.height/2 + 60)
        b1.isAntialiased = true
        addChild(b1)
        
        b2 = SKShapeNode(circleOfRadius: 40)
        b2.fillColor = Nucleobase.thymine.color()
        b2.strokeColor = b2.fillColor
        b2.position = CGPoint(x: -self.frame.width/2 + 160, y: -self.frame.height/2 + 60)
        b2.isAntialiased = true
        addChild(b2)

        b3 = SKShapeNode(circleOfRadius: 40)
        b3.fillColor = Nucleobase.cytosine.color()
        b3.strokeColor = b3.fillColor
        b3.position = CGPoint(x: self.frame.width/2 - 160, y: -self.frame.height/2 + 60)
        b3.isAntialiased = true
        addChild(b3)

        b4 = SKShapeNode(circleOfRadius: 40)
        b4.fillColor = Nucleobase.guanine.color()
        b4.strokeColor = b4.fillColor
        b4.position = CGPoint(x: self.frame.width/2 - 60, y: -self.frame.height/2 + 60)
        b4.isAntialiased = true
        addChild(b4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if b1.frame.contains(touch.location(in: self)) {
                print(1)
            }
            if b2.frame.contains(touch.location(in: self)) {
                print(2)

            }
            if b3.frame.contains(touch.location(in: self)) {
                print(3)

            }
            if b4.frame.contains(touch.location(in: self)) {
                print(4)

            }
        }
    }
    
    
}
