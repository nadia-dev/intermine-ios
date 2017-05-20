//
//  SearchFacet.swift
//  intermine-ios
//
//  Created by Nadia on 5/19/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation


class SearchFacet {
    
    private var type: String? // Category, organism.shortName
    private var contents: [String: Int]?
    
    init(withType: String?, contents: [String: Int]) {
        self.type = withType
        self.contents = contents
    }
    
    func getType() -> String? {
        return self.type
    }
    
    func getContents() -> [String: Int]? {
        return self.contents
    }

}
