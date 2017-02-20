//
//  GameScene.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        let screenWidth = Int(self.frame.size.width)
        let nodeWidth = 100
        let numNodes = screenWidth/nodeWidth + 2
       
        let top = Polynucleotide(size: numNodes, top: true)
        top.position = CGPoint(x: -self.frame.size.width/2 - 100, y: self.frame.size.height/2 - 120)
        let moveTop = SKAction.move(by: CGVector(dx: 100, dy: 0), duration: 1)
        let addTop = SKAction.run { top.addFront() }
        let actionTop = SKAction.repeatForever(SKAction.sequence([moveTop, addTop]))
        top.run(actionTop)
        addChild(top)

        let bottom = Polynucleotide(size: numNodes, top: false)
        bottom.position = CGPoint(x: -self.frame.size.width/2, y: -self.frame.size.height/2 + 120)
        let moveBottom = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 1)
        let addBottom = SKAction.run{ bottom.addBack() }
        let actionBottom = SKAction.repeatForever(SKAction.sequence([moveBottom, addBottom]))
        bottom.run(actionBottom)
        addChild(bottom)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = self.scene?.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }

    }
}
