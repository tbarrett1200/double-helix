//
//  DeoxyribonucleicAcid.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/20/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class DeoxyribonucleicAcid: SKNode {
    var top: Polynucleotide!
    var bottom: Polynucleotide!
    
    var mutations: Int = 0     
    var extraTop: Nucleotide?
    var extraBottom: Nucleotide?
    
    init(size: Int) {
        super.init()
        
        top = Polynucleotide(size: 0, top: true)
        addChild(top)

        bottom = Polynucleotide(size: size, top: false)
        addChild(bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTop(with base: Nucleobase?) -> Bool {
        let index = top.nucleotides.count
        
        guard index < bottom.nucleotides.count else { return false }
        
        let other = bottom.nucleotides[index]
        
        var mutated = false
        
        if (base == nil) || !(base!.canPair(with: other.base!)) {
            mutated = true;
            mutations += 1
        }
        
        let node = Nucleotide(base: base, mutated: mutated, alignment: .center)
        
        top?.addBack(node: node, x: other.position.x)
        
        return !mutated
    }
    
    
    func removeFront() {
        var first = top?.nucleotides.first
        
        if first == nil {
           let _ = addTop(with: nil)
        }
        
        first = top?.nucleotides.first
        
        extraTop?.removeFromParent()
        top?.nucleotides.removeFirst()
        extraTop = first

        let bottomFront = bottom?.nucleotides.first
        
        extraBottom?.removeFromParent()
        bottom?.nucleotides.removeFirst()
        extraBottom = bottomFront
        
        extraTop?.run(SKAction.fadeOut(withDuration: 0.5))
        extraBottom?.run(SKAction.fadeOut(withDuration: 0.5))
    }
    
    func addBottom() {
        bottom?.addBack()
    }
    

}
