//
//  ResultsTableViewCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/11/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class TemplateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    
    var template: Template? {
        didSet {
            descriptionLabel?.text = template?.getInfo()
            titleLabel?.text = template?.getTitle()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel?.textColor = Colors.gray
        titleLabel?.textColor = Colors.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
