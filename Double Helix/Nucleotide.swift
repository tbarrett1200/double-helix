//
//  Nucleotide.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class Nucleotide: SKNode {
    private static let sugarColor = UIColor(red: 220/255.0, green: 237/255.0, blue: 255/255.0, alpha: 1)
    private static let mutationColor = UIColor(red: 221/255.0, green: 63/255.0, blue: 74/255.0, alpha: 1)
    
    private let sugarSize = CGSize(width: 100, height: 20)
    private let baseSize = CGSize(width: 40, height: 100)
    
    public let base = Nucleobase()
    
    init(top: Bool) {
        super.init()

        let baseOrigin = CGPoint(x: -baseSize.width/2, y: 0)
        let baseNode = SKShapeNode(rect: CGRect(origin: baseOrigin, size: baseSize))
        baseNode.fillColor = base.color()
        baseNode.strokeColor = .clear
        addChild(baseNode)
        
        let sugarOrigin = CGPoint(x: -sugarSize.width/2, y: baseSize.height)
        let sugarNode = SKShapeNode(rect: CGRect(origin: sugarOrigin, size: sugarSize))
        sugarNode.fillColor = Nucleotide.sugarColor
        sugarNode.strokeColor = .clear
        addChild(sugarNode)
        
        if !top {
            zRotation = CGFloat.pi
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
