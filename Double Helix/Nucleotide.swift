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
    
    public var pair: Nucleotide?
    
    public enum AlignmentMode {
        case left, right, center
    }
    
    /**
     Creates a nucleotide with the given nucleobase. 
     - Parameter base: the nucleobase to use. 
       If null, a mutated placeholder nucleobase will by created
     - Parameter mutated: whether or not the nucleotide is a mutation in the DNA
     - Parameter alignment: the alignment of the nucleotide with respect to the origin
        - left: the left edge of the nucleotide is touching the origin
        - right: the right edge of the nucleotide is touching the origin
        - center: the nucleotide is centered with respect to the origin
    */
    init(base: Nucleobase?, mutated: Bool, alignment: AlignmentMode) {
        self.base = base
        self.mutated = mutated
        super.init()
        
        let baseColor = base == nil ? .clear: base!.color
        let sugarColor = mutated ? ColorTheme.darkRed : ColorTheme.light

        baseNode = makeBase(color: baseColor, alignment: alignment)
        sugarNode = makeSugar(color: sugarColor, alignment: alignment)
    
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
        self.init(base: Nucleobase(), mutated: false, alignment: .center)
    }
    
    convenience init(alignment: AlignmentMode) {
        self.init(base: Nucleobase(), mutated: false, alignment: alignment)
    }
    
    private func offset(for alignment: AlignmentMode) -> CGFloat {
        switch alignment {
        case .left: return 0
        case .center: return -50
        case .right: return -100
        }
    }
    
    /**
     Creates a Base component of the nucleotide
     */
    private func makeBase(color: UIColor, alignment: AlignmentMode) -> SKShapeNode {
        let size = CGSize(width: 40, height: 100)
        let origin = CGPoint(x: offset(for: alignment) + 30, y: 0)
        let node = SKShapeNode(rect: CGRect(origin: origin, size: size))
        node.fillColor = color
        node.strokeColor = color
        return node
    }
    
    /**
     Creates a Sugar component of the nucleotide
    */
    private func makeSugar(color: UIColor, alignment: AlignmentMode) -> SKShapeNode {
        let size = CGSize(width: 100, height: 20)
        let origin = CGPoint(x: offset(for: alignment), y: 100)
        let node = SKShapeNode(rect: CGRect(origin: origin, size: size))
        node.fillColor = color
        node.strokeColor = color
        return node
    }

    
}
