//
//  ListsTableViewCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/14/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    static let identifier = "ListCell"
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var countLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
