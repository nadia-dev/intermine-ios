//
//  IntermineMinesClient.swift
//  intermine-ios
//
//  Created by Nadia on 5/7/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

class IntermineMinesClient {
    
    // TODO: Debug code
    // Change so that iterates over all possible mines while searching
    
    static let mouseMine: Mine? = CacheDataStore.sharedCacheDataStore.getMouseMine()
    
    class func fetchMouseModel() {
        guard let mineUrl = self.mouseMine?.url else {
            return
        }
        IntermineAPIClient.fetchModel(mineUrl: mineUrl)
    }
    
    class func fetchMouseLists() {
        guard let mineUrl = self.mouseMine?.url else {
            return
        }
        IntermineAPIClient.fetchLists(mineUrl: mineUrl)
    }
    
    class func fetchMouseTemplates() {
        guard let mineUrl = self.mouseMine?.url else {
            return
        }
        IntermineAPIClient.fetchTemplates(mineUrl: mineUrl)
    }
    
    class func getMouseToken(userName: String, password: String) {
        guard let mineUrl = self.mouseMine?.url else {
            return
        }
        IntermineAPIClient.getToken(mineUrl: mineUrl, username: userName, password: password)
    }

}
