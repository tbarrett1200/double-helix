//
//  ColorBar.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/21/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import SpriteKit

class ColorBar: SKNode {
    
    init(size: CGSize, sections: Int) {
        super.init()
        
        let width = size.width / CGFloat(sections)
        let height = size.height
    
        for i in 0..<sections {
            let origin = CGPoint(x: CGFloat(i) * width, y: height / 2)
            let size = CGSize(width: width, height: height)
            let node = SKShapeNode(rect: CGRect(origin: origin, size: size))
            node.strokeColor = .clear
            
            switch i % 4 {
            case 0: node.fillColor = ColorTheme.red
            case 1: node.fillColor = ColorTheme.green
            case 2: node.fillColor = ColorTheme.yellow
            default: node.fillColor = ColorTheme.blue
            }
            
            addChild(node)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
