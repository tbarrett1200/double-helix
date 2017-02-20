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
    private var nucleotides = [Nucleotide]()
    private let top: Bool
    
    init(size: Int, top: Bool) {
        self.top = top
        super.init()
        for i in 0..<size {
            let nucleotide = Nucleotide(top: top)
            let location = CGFloat(i) * 100
            nucleotide.position = CGPoint(x: location, y: 0)
            nucleotides.append(nucleotide)
            addChild(nucleotide)
        }
    }
    
    func addFront() {
        let node = Nucleotide(top: top)
        node.position = CGPoint(x: nucleotides.first!.position.x - 100, y: 0)
        nucleotides.insert(node, at: 0)
        addChild(node)
        
        let last = nucleotides.removeLast()
        last.removeFromParent()
    }
    
    func addBack() {
        let node = Nucleotide(top: top)
        node.position = CGPoint(x: nucleotides.last!.position.x + 100, y: 0)
        nucleotides.append(node)
        addChild(node)
        
        let first = nucleotides.removeFirst()
        first.removeFromParent()    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
