//
//  BaseTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

enum MinesControllerType: Int {
    
    case Templates = 0
    case Lists
    case Favorites
}

class BaseTableViewController: BaseViewController, MinesTableViewDelegate {
    
    var controllerType: MinesControllerType = .Templates {
        didSet {
            if let minesView = MinesTableView.loadMinesTableView(withControllerType: controllerType) {
                self.view.addSubview(minesView)
                minesView.resizeView(toY: 0, toWidth: self.view.frame.width, toHeight: self.view.frame.height)
                minesView.delegate = self
            }
        }
    }

    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: Mines table view delegate
    
    func minesTableView(tableView: MinesTableView, didDetectUrlSelection: String?) {
        // To override
    }


}
