//
//  FacetList.swift
//  intermine-ios
//
//  Created by Nadia on 5/19/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation


class FacetList {
    
    private var mine: String? // mineName
    private var facets: [SearchFacet]?
    
    init(withMineName: String?, facets: [SearchFacet]?) {
        self.mine = withMineName
        self.facets = facets
    }
    
    func getMine() -> String? {
        return self.mine
    }
    
    func getFacets() -> [SearchFacet]? {
        return self.facets
    }
    
    func getCategoryFacets() -> [SearchFacet]? {
        return self.facets?.filter({ (facet) -> Bool in
            return facet.getType()?.lowercased() == "category"
        })
    }
    
}
