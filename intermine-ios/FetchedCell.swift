//
//  FetchedTemplateCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FetchedCell: UITableViewCell {
    
    static let identifier = "FetchedCell"
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var data: [String: String] = [:] {
        didSet {
            var infoString = ""
            var gen = 0
            for (key, value) in self.data {
                gen += 1
                var currentString = "\(key): \(value)\n"
                if gen == self.data.count {
                    currentString = "\(key): \(value)"
                }
                infoString.append(currentString)
            }
            descriptionLabel?.text = infoString
        }
    }

}
