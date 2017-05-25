//
//  MenuCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/25/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

protocol MenuCellDelegate: class {
    
}

class MenuCell: UITableViewCell {

    @IBOutlet weak var mineButton: UIButton?
    
    var mineName: String? {
        didSet {
            mineButton?.setTitle(mineName, for: .normal)
            if let mineName = self.mineName, let mine = CacheDataStore.sharedCacheDataStore.findMineByName(name: mineName) {
                mineButton?.backgroundColor = UIColor.hexStringToUIColor(hex: mine.theme)
            }
        }
    }
    
    @IBAction func mineButtonTapped(_ sender: Any) {
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
