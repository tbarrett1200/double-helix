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
    
    var label: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = ColorTheme.dark
       
        label = SKLabelNode(fontNamed: "Avenir")
        label.fontSize = 30
        label.color = ColorTheme.light
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "TAP TO START"
        label.position = CGPoint(x: frame.width/2, y: frame.height/2)
        addChild(label)
        
        let size = CGSize(width: frame.width, height: frame.height / 4)
        
        let top = ScrollingPolynucleotide(size: size, facing: .down, moving: .right)
        top.position.x = frame.width
        top.position.y = frame.height - size.height
        addChild(top)
       
        let bottom = ScrollingPolynucleotide(size: size, facing: .up, moving: .left)
        bottom.position.y = size.height
        addChild(bottom)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let view = view {
            let tutorialViewed = UserDefaults.standard.bool(forKey: "tutorialViewed")
            let scene = tutorialViewed ? GameScene(size: view.bounds.size) : TutorialScene(size: view.bounds.size)
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.presentScene(scene, transition: .fade(withDuration: 1))
        }

    }
}
