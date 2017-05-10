//
//  MinesTableViewCell.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

protocol MinesTableViewCellDelegate: class {
    
    func minesTableViewCell(cell: MinesTableViewCell, didDetectButtonTapWithUrl: String?)
}

class MinesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mineButton: UIButton?
    
    weak var delegate: MinesTableViewCellDelegate?
    
    var mineName: String? = "" {
        didSet {
            mineButton?.setTitle(mineName, for: .normal)
        }
    }

    var mineColor: String? = "#939393" {
        didSet {
            mineButton?.backgroundColor = UIColor.hexStringToUIColor(hex: mineColor)
        }
    }
    
    var mineUrl: String? = nil
    
    // MARK: Table view cell

    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.height = General.minesCellHeight
        self.selectionStyle = .none
    }
    
    // MARK: Actions
    
    @IBAction func tapMineButton(_ sender: Any) {
        self.delegate?.minesTableViewCell(cell: self, didDetectButtonTapWithUrl: mineUrl)
    }
    
    
}
