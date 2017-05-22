//
//  SearchFacet.swift
//  intermine-ios
//
//  Created by Nadia on 5/19/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

class FormattedFacet {
    
    private var title: String?
    private var count: String?
    
    init(withTitle: String?, count: String) {
        self.title = withTitle
        self.count = count
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func getCount() -> String? {
        return self.count
    }
    
}


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
    
    func getFormattedContents() -> [FormattedFacet]? {
        // list of formatted facets
        guard let contents = self.contents else {
            return nil
        }
        var formattedFacets: [FormattedFacet] = []
        for (key, value) in contents {
            formattedFacets.append(FormattedFacet(withTitle: key, count: "\(value)"))
        }
        return formattedFacets
    }

}
