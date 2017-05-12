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
    static let templateResults = "/service/template/results"
}

struct General {
    static let modelName = "Cache"
    static let minesCellHeight = CGFloat(60.0)
}

struct Icons {
    static let search = UIImage.init(icon: .FASearch, size: CGSize(width: 35, height: 35))
    static let templates = UIImage.init(icon: .FATasks, size: CGSize(width: 35, height: 35))
    static let lists = UIImage.init(icon: .FAList, size: CGSize(width: 35, height: 35))
    static let bookmark = UIImage.init(icon: .FABookmark, size: CGSize(width: 35, height: 35))
    static let login = UIImage.init(icon: .FASignIn, size: CGSize(width: 35, height: 35))
    static let close = UIImage.init(icon: .FATimes, size: CGSize(width: 40, height: 40))
}

struct Colors {
    static let chelseaCucumber = UIColor.hexStringToUIColor(hex: "#8CA855")
    static let conifer = UIColor.hexStringToUIColor(hex: "#BFD93B")
    static let white = UIColor.white
    static let gray = UIColor.hexStringToUIColor(hex: "#8F8F8F")
}

struct Operations {
    static let equalsEquals = "=="
    static let like = "LIKE"
    static let equals = "="
    static let notEquals = "!="
    static let notLike = "NOT LIKE"
    static let notEqualsEquals = "!=="
    static let doesNotContain = "DOES NOT CONTAIN"
    static let contains = "CONTAINS"
    static let moreOrEqual = ">="
    static let lessOrEqual = "<="
    static let more = ">"
    static let less = "<"
}

struct Notifications {
    static let operationChanged = "notification.operation.changed"
}
