//
//  ScrollingPolynucleotide.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/22/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class ScrollingPolynucleotide: SKNode {
    
    private var nucleotides = [Nucleotide]()
    
    enum HorizontalDirection {
        case left, right
    }
    
    enum VerticalDirection {
        case up, down
    }
    
    private let facing: VerticalDirection
    private let moving: HorizontalDirection
    private var numNucleotides = 0
    
    init(size: CGSize, facing: VerticalDirection, moving: HorizontalDirection) {
        
        self.facing = facing
        self.moving = moving
        
        super.init()
        
        //the scale ratio needed to make a nucleotide fit the vertical space
        let scale = size.height / Nucleotide.size.height
        
        setScale(scale)
        
        //the width of a nucleotide with the scale applied
        let width = Nucleotide.size.width * scale
        
        //the amount of scaled nucleotides needed to fit the horizontal space
        let count = Int(size.width / width) + 1
        
        for _ in 0...count {
            addLast()
        }
        
        run(SKAction.repeatForever(scroll()))
    }
    
    private func addRight() {
        let node = Nucleotide()
        node.position.x = CGFloat(numNucleotides) * Nucleotide.size.width
        node.zRotation = facing == .up ? CGFloat.pi : 0
        addChild(node)
        nucleotides.append(node)
        numNucleotides += 1
    }
    
    private func addLeft() {
        let node = Nucleotide()
        node.position.x = CGFloat(numNucleotides) * -Nucleotide.size.width
        node.zRotation = facing == .up ? CGFloat.pi : 0
        addChild(node)
        nucleotides.append(node)
        numNucleotides += 1
    }
    
    private func addLast() {
        if moving == .left { addRight() }
        else { addLeft() }
    }
    
    private func removeFirst() {
        let node = nucleotides.removeFirst()
        node.removeFromParent()
    }
    
    private func scroll() -> SKAction {
        let width = Nucleotide.size.width * xScale
        let dx = moving == .left ? -width : width
        let vector = CGVector(dx: dx, dy:0)
        let move = SKAction.move(by: vector, duration: 0.5)
        let change = SKAction.run {
            self.removeFirst()
            self.addLast()
        }
        return SKAction.sequence([move, change])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
