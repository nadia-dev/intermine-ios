//
//  FetchedTemplateCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FetchedTemplateCell: UITableViewCell {
    
    static let identifier = "FetchedTemplateCell"
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var template: [String: String] = [:] {
        didSet {
            var infoString = ""
            var gen = 0
            for (key, value) in self.template {
                gen += 1
                var currentString = "\(key): \(value)\n"
                if gen == self.template.count {
                    currentString = "\(key): \(value)"
                }
                infoString.append(currentString)
            }
            descriptionLabel?.text = infoString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
