

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

    private var dna: DeoxyribonucleicAcid!

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

        
        let screenWidth = Int(self.frame.size.width)
        let nodeWidth = 100
        let numNodes = screenWidth/nodeWidth + 3
        
        dna = DeoxyribonucleicAcid(size: numNodes)
        dna.position = CGPoint(x: frame.width+50, y: 0.5 * (frame.height - adenine.frame.maxY) + adenine.frame.maxY)
        
        let time = Double((frame.width-50) * 0.005)
        
        let moveDNA = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 0.5)
        let addDNA = SKAction.run{
            self.dna.addBottom();
            self.dna.removeFront();
            self.mutationLabel.text = "MUTATIONS: \(self.dna.mutations)"
            if self.dna.mutations >= self.maxMutations {
                self.didLoseGame()
            }
        }
        let actionDNA = SKAction.repeatForever(SKAction.sequence([moveDNA, addDNA]))
        
        dna.run(SKAction.moveBy(x: -frame.width+150, y: 0, duration: time)) {
            self.dna.run(actionDNA)
        }
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard dna.mutations < maxMutations else { return }
        
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
        
        if let newBase = base {
            if dna.addTop(with: newBase) {
                GameScene.score += 1
            }
            scoreLabel.text = "SCORE: \(GameScene.score)"
            mutationLabel.text = "MUTATIONS: \(self.dna.mutations)"

        }
    }
    
    
}
