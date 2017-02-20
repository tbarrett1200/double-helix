//
//  Nucleobase.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/19/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation
import UIKit

enum Nucleobase: Int {
    case adenine = 0
    case thymine = 3
    case cytosine = 1
    case guanine = 2
    
    init() {
        let random = Int(arc4random_uniform(4))
        self.init(rawValue: random)!
    }
    
    func canPair(with base: Nucleobase) -> Bool {
        return self.rawValue + base.rawValue == 3
    }
    
    func color() -> UIColor {
        switch self {
        case .adenine: return UIColor(red: 170/255.0, green: 231/255.0, blue: 208/255.0, alpha: 1)
        case .thymine: return UIColor(red: 72/255.0, green: 157/255.0, blue: 255/255.0, alpha: 1)
        case .guanine: return UIColor(red: 212/255.0, green: 224/255.0, blue: 155/255.0, alpha: 1)
        case .cytosine: return UIColor(red: 255/255.0, green: 166/255.0, blue: 158/255.0, alpha: 1)
        }
    }
}
