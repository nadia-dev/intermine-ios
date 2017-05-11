//
//  TemplatesList.swift
//  intermine-ios
//
//  Created by Nadia on 5/11/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

class TemplatesList {
    
    // TODO: Should it be cached in CD?
    
    private let templates: [Template]?
    private let mine: String?
    
    init(withTemplates: [Template]?, mine: String?) {
        self.templates = withTemplates
        self.mine = mine
    }
    
    func size() -> Int? {
        return templates?.count
    }
    
}
