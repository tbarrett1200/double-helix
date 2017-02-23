//
//  UserData.swift
//  Double Helix
//
//  Created by Thomas Barrett on 2/21/17.
//  Copyright © 2017 Thomas Barrett. All rights reserved.
//

import Foundation

class UserData : NSCoding {
    
    public var highSore: Int64 = 0
    
    required init?(coder aDecoder: NSCoder) {
        highSore = aDecoder.decodeInt64(forKey: "highScore")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(highSore, forKey: "highScore")
    }
}
