//
//  TemplatesViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/8/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class TemplatesViewController: BaseTableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        controllerType = .Templates
    }
    
    // MARK: Mines table view delegate
    
    override func minesTableView(tableView: MinesTableView, didDetectUrlSelection: String?) {
        guard let mineUrl = didDetectUrlSelection else {
            return
        }
        
        if let resultsVC = ResultsTableViewController.resultsTableViewController(withMineUrl: mineUrl) {
            self.navigationController?.pushViewController(resultsVC, animated: true)
        }
    }


}
