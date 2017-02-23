//
//  Polynucleotide.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class Polynucleotide: SKNode {
    
    public var nucleotides = [Nucleotide]()
    
    private let top: Bool

    init(size: Int, top: Bool) {
        self.top = top
        
        super.init()
        
        for i in 0..<size {
            let node = Nucleotide()
            let location = CGFloat(i) * 100
            node.position = CGPoint(x: location, y: 0)
            if !top { node.zRotation = CGFloat.pi }
            nucleotides.append(node)
            addChild(node)
        }
    }
    

    func addFront() {
        let node = Nucleotide()
        if !top { node.zRotation = CGFloat.pi }
        node.position = CGPoint(x: nucleotides.first!.position.x - 100, y: 0)
        nucleotides.insert(node, at: 0)
        addChild(node)

    }
    
    func removeFront() {
        let first = nucleotides.removeFirst()
        first.removeFromParent()
    }
    
    
    
    func addBack() {
        let node = Nucleotide()
        if !top { node.zRotation = CGFloat.pi }
        node.position = CGPoint(x: nucleotides.last!.position.x + 100, y: 0)
        nucleotides.append(node)
        addChild(node)
    }
    
    func addBack(node: Nucleotide, x: CGFloat) {
        if !top { node.zRotation = CGFloat.pi }
        node.position = CGPoint(x: x, y: 0)
        nucleotides.append(node)
        addChild(node)

    }
    
    func removeBack() {
        let last = nucleotides.removeLast()
        last.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
