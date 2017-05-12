//
//  TemplateQuery.swift
//  intermine-ios
//
//  Created by Nadia on 5/11/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

class TemplateQuery {
    
    private let value: String?
    private let code: String?
    private let op: String?
    private let constraint: String? // "path"
    
    init(withValue: String?, code: String?, op: String?, constraint: String?) {
        self.value = withValue
        self.code = code
        self.op = op
        self.constraint = constraint
    }
    
    func isLookupQuery() -> Bool {
        return value?.lowercased() == "lookup"
    }
    
    func isOpQuery() -> Bool {
        if let value = self.value {
            return value.lowercased() != "lookup"
        }
        return false
    }
    
    func getOperation() -> String? {
        return self.op
    }
    
}
