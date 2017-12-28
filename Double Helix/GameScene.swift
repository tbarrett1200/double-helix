

//
//  GameScene.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/20/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class GameScene: SKScene {
    private let maxMutations = 5

    public static var score = 0 
    public static var highScore: Int = 0

    private var dna: DNA!

    private var scoreLabel: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    private var mutationLabel: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    
    private var adenine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var thymine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var cytosine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var guanine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    
    override func didMove(to view: SKView) {
        
        
        backgroundColor = ColorTheme.dark
        
        GameScene.score = 0
        GameScene.highScore = UserDefaults.standard.integer(forKey: "highScore")
        
        reportScoreToLeaderboard()

        adenine.fillColor = Nucleobase.adenine.color
        adenine.position = CGPoint(x: 60, y: 60)
        
        thymine.fillColor = Nucleobase.thymine.color
        thymine.position = CGPoint(x: 160, y: 60)
       
        cytosine.fillColor = Nucleobase.cytosine.color
        cytosine.position = CGPoint(x: frame.width - 160, y: 60)
       
        guanine.fillColor = Nucleobase.guanine.color
        guanine.position = CGPoint(x: frame.width - 60, y: 60)

        for b in [adenine!, thymine!, cytosine!, guanine!] {
            b.strokeColor = b.fillColor
            b.isAntialiased = true
            addChild(b)
        }
        scoreLabel.fontSize = 24
        scoreLabel.text = "SCORE: 0"
        scoreLabel.verticalAlignmentMode = .top
        scoreLabel.position = CGPoint(x: frame.width/2, y: adenine.frame.maxY - 10)
        
        mutationLabel.fontSize = 18
        mutationLabel.text = "MUTATIONS: 0"
        mutationLabel.verticalAlignmentMode = .bottom
        mutationLabel.position = CGPoint(x: frame.width/2, y: adenine.frame.minY + 10)
        
        for l in [scoreLabel!, mutationLabel!] {
            l.color = ColorTheme.light
            l.horizontalAlignmentMode = .center
            addChild(l)
        }
 
        dna = DNA(size: CGSize(width:frame.size.width, height: frame.size.height/2))
        dna.position = CGPoint(x: frame.width, y: 0.5 * (frame.height - adenine.frame.maxY) + adenine.frame.maxY)
        addChild(dna)
    }
    
    
    
    func didLoseGame() {
        if GameScene.score > GameScene.highScore {
            GameScene.highScore = GameScene.score
            UserDefaults.standard.set(GameScene.highScore, forKey: "highScore")
        }
        
        reportScoreToLeaderboard()
        
        if let view = view {
            let scene = GameOverScene(size: view.bounds.size)
            scene.scaleMode = .aspectFit
            view.ignoresSiblingOrder = true
            view.presentScene(scene, transition: .fade(withDuration: 1))
        }
    }

    func reportScoreToLeaderboard() {
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let score = GKScore(leaderboardIdentifier: "tbarrett1200.doubleHelix.highScore", player: GKLocalPlayer.localPlayer())
            score.value = Int64(GameScene.highScore)
            GKScore.report([score], withCompletionHandler: nil)
        }
    }

    func mutationsChanged() {
        mutationLabel.text = "MUTATIONS: \(self.dna.mutations)"
        if dna.mutations == dna.maxMutations {
            didLoseGame()
        }
    }
    
    func scoreChanged() {
        scoreLabel.text = "SCORE: \(GameScene.score)"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        var base: Nucleobase? = nil
        
        if let touch = touches.first {
            if adenine.frame.contains(touch.location(in: self)) {
                base = .adenine
            } else if thymine.frame.contains(touch.location(in: self)) {
                base = .thymine
            } else if cytosine.frame.contains(touch.location(in: self)) {
                base = .cytosine
            } else if guanine.frame.contains(touch.location(in: self)) {
                base = .guanine
            }
        }
        
        if let base = base {
            dna.addNucleotide(with: base)
        }
    }
    
    
}
