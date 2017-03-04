//
//  GameOverScene.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/20/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    

    
    var title1 = SKLabelNode(fontNamed: "Avenir")
    var title2 = SKLabelNode(fontNamed: "Avenir")
    var scoreLabel = SKLabelNode(fontNamed: "Avenir")
    var restart = SKLabelNode(fontNamed: "Avenir")
    var tutorial = SKLabelNode(fontNamed: "Avenir")
    var leaderboard = SKLabelNode(fontNamed: "Avenir")
    var highscore = SKLabelNode(fontNamed: "Avenir")
    var bar: ColorBar!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor(red: 23/255.0, green: 26/255.0, blue: 33/255.0, alpha: 1)

        title1.text = "GENOME REPLICATION"
        title1.fontSize = 48
        title1.fontColor = ColorTheme.light
        title1.position.x = frame.width/2
        title1.position.y = frame.height - 1 * title1.frame.height - 10
        addChild(title1)
        
        title2.text = "ABORTED"
        title2.fontSize = 48
        title2.fontColor = ColorTheme.light
        title2.position.x = frame.width/2
        title2.position.y = frame.height - 2 * title1.frame.height - 20
        addChild(title2)

        restart.text = "RESTART"
        restart.fontSize = 24
        restart.fontColor = ColorTheme.light
        restart.position.x = restart.frame.width/2 + 20
        restart.position.y = 20
        addChild(restart)
        
        leaderboard.text = "LEADERBOARD"
        leaderboard.fontSize = 24
        leaderboard.horizontalAlignmentMode = .center
        leaderboard.fontColor = ColorTheme.light
        leaderboard.position.x = frame.width/2
        leaderboard.position.y = 20
        addChild(leaderboard)

        
        tutorial.text = "TUTORIAL"
        tutorial.fontSize = 24
        tutorial.fontColor = ColorTheme.light
        tutorial.position.x = self.frame.width - tutorial.frame.width/2 - 20
        tutorial.position.y = 20
        addChild(tutorial)
        
        bar = ColorBar(size: CGSize(width: self.frame.size.width, height: 20), sections: 8)
        bar.position = CGPoint(x: 0, y: restart.frame.maxY + 10)
        addChild(bar)
        
        scoreLabel.text = "SCORE: \(GameScene.score)"
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = ColorTheme.light
        scoreLabel.verticalAlignmentMode = .bottom
        scoreLabel.position.y = 5
        
        highscore.text = "BEST: \(GameScene.highScore)"
        highscore.fontSize = 24
        highscore.fontColor = ColorTheme.light
        highscore.verticalAlignmentMode = .top
        highscore.position.y = -5
        
        let scoreNode = SKNode()
        scoreNode.addChild(scoreLabel)
        scoreNode.addChild(highscore)
        scoreNode.position.x = frame.width/2
        scoreNode.position.y = bar.frame.maxY + 0.5 * (title2.frame.minY - bar.frame.maxY)
        addChild(scoreNode)

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if restart.contains(touch.location(in: self)) {
                if let view = view {
                    let scene = GameScene(size: view.bounds.size)
                    scene.scaleMode = .aspectFit
                    view.ignoresSiblingOrder = true
                    view.presentScene(scene, transition: .fade(withDuration: 1))
                }
            } else if tutorial.contains(touch.location(in: self)) {
                if let view = view {
                    let scene = TutorialScene(size: view.bounds.size)
                    scene.scaleMode = .aspectFit
                    view.ignoresSiblingOrder = true
                    view.presentScene(scene, transition: .fade(withDuration: 1))
                }
            } else if leaderboard.contains(touch.location(in: self)) {
                GameViewController.controller?.showLeader()
            }
        }
    }
}
