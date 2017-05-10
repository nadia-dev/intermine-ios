//
//  MinesTableViewCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class MinesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.height = General.minesCellHeight
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
