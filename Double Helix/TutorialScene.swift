//
//  TutorialScene.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/23/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class TutorialScene: SKScene {
    private let maxMutations = 5
    
    public static var score = 0
    public static var highScore: Int = 0
    
    private var dna: DeoxyribonucleicAcid!
    
    private var scoreLabel: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    private var mutationLabel: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    private var tutorialLabel1: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    private var tutorialLabel2: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")
    private var tutorialLabel3: SKLabelNode! = SKLabelNode(fontNamed: "Avenir")

    private var tutorialNode: SKNode = SKNode()
    
    private var adenine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var thymine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var cytosine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    private var guanine: SKShapeNode! = SKShapeNode(circleOfRadius: 40)
    
    private var tutorial = 0
    private var nextBase: Nucleobase!
    private var nextButton: SKShapeNode!

    private var ready = true
    
    override func didMove(to view: SKView) {
        
        backgroundColor = ColorTheme.dark
        
        tutorialLabel1.fontSize = 24
        tutorialLabel1.fontColor = ColorTheme.light
        tutorialLabel1.verticalAlignmentMode = .top
        tutorialLabel1.position.y = 0
        tutorialNode.addChild(tutorialLabel1)

        tutorialLabel2.fontSize = 24
        tutorialLabel2.fontColor = ColorTheme.light
        tutorialLabel2.verticalAlignmentMode = .top
        tutorialLabel2.position.y = -tutorialLabel1.frame.height - 30
        tutorialNode.addChild(tutorialLabel2)
        
        tutorialLabel3.text = "TAP TO CONTINUE"
        tutorialLabel3.fontSize = 16
        tutorialLabel3.fontColor = ColorTheme.light
        tutorialLabel3.verticalAlignmentMode = .top
        tutorialLabel3.position.y = -tutorialLabel1.frame.height - tutorialLabel2.frame.height - 60
        tutorialNode.addChild(tutorialLabel3)

        tutorialNode.position.x = frame.width/2
        tutorialNode.position.y = frame.height - 20
        addChild(tutorialNode)
        
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
        
        scoreLabel.fontSize = 36
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
        addChild(dna)
        
        tutorial0()
    }
    
    private func scroll() -> SKAction {
        let moveDNA = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 0.5)
        
        let addDNA = SKAction.run{
            self.dna.addBottom();
            self.dna.removeFront();
            self.mutationLabel.text = "MUTATIONS: \(self.dna.mutations)"
        }
        
        let scrollDNA = SKAction.sequence([moveDNA, addDNA])
        return scrollDNA
    }
    
    private func tutorial0() {
        tutorialLabel1.text = "COMPLETE THE DNA SEQUENCE"
        tutorialLabel2.text = "BY FILLING IN THE MISSING PIECES"

        let dx = frame.width/2 + 50
        let time = Double(dx * 0.005)
        
        dna.run(SKAction.moveBy(x: -dx, y: 0, duration: time))
    }
    
    private func tutorial1() {
        tutorialLabel1.text = "MATCH EACH PIECE"
        tutorialLabel2.text = "WITH ITS PAIR COLOR"
        self.tutorialNode.run(SKAction.fadeIn(withDuration: 0.5))
    }
    
    private func tutorial2() {
        self.nextBase = self.dna.bottom.nucleotides.first!.base
        self.flashButton(base: self.nextBase.complement)
        tutorial += 1
    }
    
    private func tutorial3() {
        tutorialLabel1.text = "AFTER FIVE MISTAKES"
        tutorialLabel2.text = "THE GAME IS OVER"
        self.tutorialNode.run(SKAction.fadeIn(withDuration: 0.5))
        tutorial += 1
    }
    
    private func flashButton(base: Nucleobase) {
        switch base {
        case .adenine: nextButton = adenine
        case .thymine: nextButton = thymine
        case .cytosine: nextButton = cytosine
        case .guanine: nextButton = guanine
        }
        
        let grow = SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 0.2)
        let change = SKAction.run {
            self.nextButton.fillColor = ColorTheme.light
            self.nextButton.strokeColor = ColorTheme.light
        }
        let shrink = SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 0.2)
        let unchange = SKAction.run {
            self.nextButton.fillColor = self.nextBase.complement.color
            self.nextButton.strokeColor = self.nextBase.complement.color
        }
        nextButton.run(SKAction.repeatForever(SKAction.sequence([grow, shrink, change, grow, shrink, unchange])))
    }
    

    private func addTop() {
        if dna.addTop(with: nextBase.complement) {
            TutorialScene.score += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ready {
        switch tutorial {
        case 0:
            ready = false
            tutorialNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                self.tutorial1()
                self.tutorial += 1
                self.ready = true

            }
        case 1:
            tutorialNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                self.tutorial2()
                self.tutorial += 1
                self.ready = true
            }
        case 2...6:
            if nextButton.frame.contains((touches.first?.location(in: self))!) {
                self.nextButton.removeAllActions()
                self.nextButton.position.y = 60
                self.nextButton.fillColor = self.nextBase.complement.color
                self.nextButton.strokeColor = self.nextBase.complement.color
                self.addTop()
                self.scoreLabel.text = "SCORE: \(TutorialScene.score)"
                self.dna.run(scroll()) {
                    if self.tutorial < 6 {
                        self.tutorial2()
                    } else {
                        self.tutorial3()
                    }
                }
            }
        default:
            UserDefaults.standard.set(true, forKey: "tutorialViewed")
            if let view = view {
                let scene = GameScene(size: view.bounds.size)
                scene.scaleMode = .aspectFit
                view.ignoresSiblingOrder = true
                view.presentScene(scene, transition: .fade(withDuration: 1))
            }
        }
        }
    }
}
