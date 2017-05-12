//
//  Dictionary+Utils.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

extension Dictionary {
    
    public init(keys: [Key], values: [Value]) {
        precondition(keys.count == values.count)
        self.init()
        for (index, key) in keys.enumerated() {
            self[key] = values[index]
        }
    }
    
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
