//
//  RightHeaderCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/19/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class RightHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel?
    static let identifier = "RightHeaderCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
