//
//  Template.swift
//  intermine-ios
//
//  Created by Nadia on 5/11/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

class Template {
    
    private let title: String?
    private let description: String?
    private let queryList: [TemplateQuery]?
    
    init(withTitle: String?, description: String?, queryList: [TemplateQuery]?) {
        self.title = withTitle
        self.description = description
        self.queryList = queryList
    }
    
    // MARK: Public methods
    
    func getInfo() -> String? {
        return self.description
    }
    
    func getTitle() -> String? {
        return self.title
    }
    
    func lookupQueryCount() -> Int {
        guard let list = queryList else {
            return 0
        }
        return list.filter({ (query: TemplateQuery) -> Bool in
            return query.isLookupQuery()
        }).count
    }
    
    func opQueryCount() -> Int {
        guard let list = queryList else {
            return 0
        }
        return list.filter({ (query: TemplateQuery) -> Bool in
            return query.isOpQuery()
        }).count
    }
    
    func totalQueryCount() -> Int {
        guard let list = queryList else {
            return 0
        }
        return list.count
    }
    
    func getLookupQueries() -> [TemplateQuery] {
        guard let list = queryList else {
            return []
        }
        return list.filter({ (query: TemplateQuery) -> Bool in
            return query.isLookupQuery()
        })
    }
    
    func getOpQueries() -> [TemplateQuery] {
        guard let list = queryList else {
            return []
        }
        return list.filter({ (query: TemplateQuery) -> Bool in
            return query.isOpQuery()
        })
    }
    
    func getQueriesSortedByType() -> [TemplateQuery] {
        // returned array shows op queires first, then lookup queries
        return self.getOpQueries() + self.getLookupQueries()
    }
    
}
