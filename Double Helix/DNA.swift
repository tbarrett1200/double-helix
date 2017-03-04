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
    public var nucleotides = [Nucleotide]()
   
    private var count = 0
    
    private var numNucleotides = 0

    private var time = 0.5
    
    private var size: CGSize?
    
    init(size: CGSize) {
        
        super.init()
        
        self.size = size
        
        //the scale ratio needed to make a nucleotide fit the vertical space
        let scale = size.height / Nucleotide.size.height
        
        setScale(scale)
        
        //the width of a nucleotide with the scale applied
        let width = Nucleotide.size.width * scale
        
        //the amount of scaled nucleotides needed to fit the horizontal space
        let count = Int(size.width / width) + 1
        
        for _ in 0...count {
            addRight()
        }
        
        let moveAction = moveToPosition()
        let scrollAction = SKAction.repeatForever(scroll())
        run(SKAction.sequence([moveAction, scrollAction]))
    }
    
    public func moveToPosition() -> SKAction {
        let displacement = nucleotides.first!.position.x - Nucleotide.size.width
        return SKAction.move(by: CGVector(dx: displacement, dy: 0), duration: time * Double(displacement) / Double(Nucleotide.size.width))
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
        return SKAction.move(by: CGVector(dx: Nucleotide.size.width, dy: 0), duration: time)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

