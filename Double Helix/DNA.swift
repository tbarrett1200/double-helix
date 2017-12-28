//
//  DNA.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/28/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit


class DNA: SKNode {
    private let size: CGSize
    private let time = 0.5
    public let maxMutations = 5
    private var nodeWidth:CGFloat?
    public var numNucleotides = 0

    public var nucleotides = [Nucleotide]()
    public var mutations = 0 {
        didSet {
            let scene = self.scene as! GameScene
            scene.mutationsChanged()
        }
    }
    
    init(size: CGSize) {
        self.size = size

        super.init()
        

        //the scale ratio needed to make a nucleotide fit the vertical space
        let scale = size.height / Nucleotide.size.height / 2
        
        setScale(scale)
        
        //the width of a nucleotide with the scale applied
        nodeWidth = Nucleotide.size.width * scale
        
        //the amount of scaled nucleotides needed to fit the horizontal space
        let count = Int(size.width / nodeWidth!) + 1
        
        for _ in 0...count {
            addRight()
        }
        
        let moveAction = moveToPosition()
        let firstAction = SKAction.run(fade)
        let scrollAction = SKAction.repeatForever(scroll())
        run(SKAction.sequence([moveAction, firstAction, scrollAction]))
    }
    
    public func moveToPosition() -> SKAction {
        let distance = size.width - nodeWidth!
        let time = self.time * Double(distance) / Double(nodeWidth!)
        print("displacement: \(distance) time: \(time)")
        return SKAction.move(by: CGVector(dx: -distance, dy: 0), duration: time)
    }
    
    private func addRight() {
        let node = Nucleotide(alignment: .right)
        node.position.x = CGFloat(numNucleotides) * Nucleotide.size.width
        node.zRotation = CGFloat.pi
        addChild(node)
        nucleotides.append(node)
        numNucleotides += 1
    }
    
    public func scroll() -> SKAction {
        
        let move = SKAction.move(by: CGVector(dx: -(nodeWidth!), dy: 0), duration: 0.5)
        
        let add = SKAction.run {
            self.addRight()
            
            let first = self.nucleotides.removeFirst()
            first.pair?.removeFromParent()
            first.removeFromParent()
            
            self.fade()
            
        }
        
        return SKAction.sequence([move, add])
    }
    
    private func fade() {
        let first = self.nucleotides[0]
        first.run(SKAction.fadeOut(withDuration: 0.5))
        first.pair?.run(SKAction.fadeOut(withDuration: 0.5))
        
        if first.pair == nil {
            self.addNucleotide(with: nil)
            mutations += 1
        }
    }
    
    public func addNucleotide(with base: Nucleobase?) {
        for node in nucleotides {
            if node.pair == nil {
                let mutated = !node.base!.canPair(with: base)
 
                let pair = Nucleotide(base: base, mutated: mutated, alignment: .left)
                pair.position.x = node.position.x
                addChild(pair)
                
                node.pair = pair
                
                if mutated {
                    mutations += 1
                } else {
                    GameScene.score += 1
                    let scene = self.scene as! GameScene
                    scene.scoreChanged()
                }
                return
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

