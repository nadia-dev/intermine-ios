//
//  SearchResult.swift
//  intermine-ios
//
//  Created by Nadia on 5/17/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation


class SearchResult: NSObject {
    
    private var type: String?
    private var fields: [String: AnyObject]?
    private var mineName: String?
    
    init(withType: String?, fields: [String: AnyObject]?, mineName: String?) {
        self.type = withType
        self.fields = fields
        self.mineName = mineName
    }
    
    func viewableRepresentation() -> [String: String] {
        var representation: [String: String] = [:]
        if let type = self.type {
            representation["type"] = type
        }
        if let mineName = self.mineName {
            representation["mine"] = mineName
        }
        if let fields = self.fields {
            for (key, value) in fields {
                representation[key] = "\(value)"
            }
        }
        return representation
    }
    
    
}
