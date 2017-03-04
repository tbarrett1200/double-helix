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
enum Nucleobase {
    case adenine, thymine, cytosine, guanine
    
    /**
     Creates a new nuclebase of a random type
     */
    init() {
        let random = Int(arc4random_uniform(4))
        switch random {
        case 0: self = .adenine
        case 1: self = .thymine
        case 2: self = .guanine
        default: self = .cytosine
        }
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

    /**
     Returns the complementary base type
     */
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
        return self.complement == base
    }
}
