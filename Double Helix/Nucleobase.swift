//
//  Nucleobase.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import UIKit

/**
 A nitrogenous base that composes DNA
 */
enum Nucleobase: Int {
    case adenine = 0
    case thymine = 3
    case cytosine = 1
    case guanine = 2
    
    /**
     Creates a new nuclebase of a random type
     */
    init() {
        let random = Int(arc4random_uniform(4))
        self.init(rawValue: random)!
    }
    
    /**
     The representative color of the nucleobase. Matching bases have similar hues
     */
    var color: UIColor {
        switch self {
        case .adenine: return ColorTheme.green
        case .thymine: return ColorTheme.blue
        case .guanine: return ColorTheme.yellow
        case .cytosine: return ColorTheme.red
        }
    }

    var complement: Nucleobase {
        switch self {
        case .adenine: return .thymine
        case .thymine: return .adenine
        case .guanine: return .cytosine
        case .cytosine: return .guanine
        }
    }
    
    /**
     Returns whether or not the nucleobase can pair with the other specified base
     */
    func canPair(with base: Nucleobase) -> Bool {
        return self.rawValue + base.rawValue == 3
    }
}
