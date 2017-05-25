//
//  AppManager.swift
//  intermine-ios
//
//  Created by Nadia on 5/24/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation


class AppManager {
    
    var selectedMine: String = "YeastMine"
    
    // MARK: Shared Instance
    
    static let sharedManager : AppManager = {
        let instance = AppManager()
        return instance
    }()
}

