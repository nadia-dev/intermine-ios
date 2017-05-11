//
//  FavoritesViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/8/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controllerType = .Favorites
    }
    
    // MARK: Mines table view delegate
    
    override func minesTableView(tableView: MinesTableView, didDetectUrlSelection: String?) {
        // TODO: To implement
    }


}
