//
//  File.swift
//  intermine-ios
//
//  Created by Nadia on 5/9/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

extension String {
    
    public static func localize(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
