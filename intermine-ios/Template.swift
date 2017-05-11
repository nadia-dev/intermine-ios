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
    
}
