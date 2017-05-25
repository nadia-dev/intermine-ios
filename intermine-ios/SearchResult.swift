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
    private var id: String?
    
    init(withType: String?, fields: [String: AnyObject]?, mineName: String?, id: String?) {
        self.type = withType
        self.fields = fields
        self.mineName = mineName
        self.id = id
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
