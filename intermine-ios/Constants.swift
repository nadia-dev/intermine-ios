//
//  Constants.swift
//  intermine-ios
//
//  Created by Nadia on 5/7/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

struct Endpoints {
    static let serviceListing = "/service"
    static let modelDescription = "/service/model"
    static let lists = "/service/lists"
    static let templates = "/service/templates"
    static let tokens = "/service/user/tokens"
}

struct General {
    static let modelName = "Cache"
}

struct Icons {
    static let search = UIImage.init(icon: .FASearch, size: CGSize(width: 35, height: 35))
    static let templates = UIImage.init(icon: .FATasks, size: CGSize(width: 35, height: 35))
    static let lists = UIImage.init(icon: .FAList, size: CGSize(width: 35, height: 35))
    static let bookmark = UIImage.init(icon: .FABookmark, size: CGSize(width: 35, height: 35))
    static let login = UIImage.init(icon: .FASignIn, size: CGSize(width: 35, height: 35))
}
