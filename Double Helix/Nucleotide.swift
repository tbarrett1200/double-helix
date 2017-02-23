//
//  Nucleotide.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

/**
 A single link in a DNA chain. It contains a nucleobase and can connect with other nucleotides
 */
class Nucleotide: SKNode {

    public static let size = CGSize(width: 100, height: 120)
    public let base: Nucleobase?
    public let mutated: Bool
    
    private var baseNode: SKShapeNode!
    private var sugarNode: SKShapeNode!

    /**
     Creates a nucleotide with the given nucleobase. 
     - Parameter base: the nucleobase to use. 
       If null, a mutated placeholder nucleobase will by created
    */
    init(base: Nucleobase?, mutated: Bool) {
        self.base = base
        self.mutated = mutated
        super.init()
        
        let baseColor = base == nil ? .clear: base!.color
        let sugarColor = mutated ? ColorTheme.darkRed : ColorTheme.light

        baseNode = makeBase(color: baseColor)
        sugarNode = makeSugar(color: sugarColor)
    
        addChild(baseNode)
        addChild(sugarNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Creates a nucleotide with a random base
     */
    convenience override init() {
        self.init(base: Nucleobase(), mutated: false)
    }
    
    /**
     Creates a Base component of the nucleotide
     */
    private func makeBase(color: UIColor) -> SKShapeNode {
        let size = CGSize(width: 40, height: 100)
        let origin = CGPoint(x: -size.width/2, y: 0)
        let node = SKShapeNode(rect: CGRect(origin: origin, size: size))
        node.fillColor = color
        node.strokeColor = .clear
        return node
    }
    
    /**
     Creates a Sugar component of the nucleotide
    */
    private func makeSugar(color: UIColor) -> SKShapeNode {
        let size = CGSize(width: 100, height: 20)
        let origin = CGPoint(x: -size.width/2, y: 100)
        let node = SKShapeNode(rect: CGRect(origin: origin, size: size))
        node.fillColor = color
        node.strokeColor = .clear
        return node
    }

    
}
