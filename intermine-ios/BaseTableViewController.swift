//
//  BaseTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {

    // MARK: View Controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let minesView = MinesTableView.loadMinesTableView() {
            self.view.addSubview(minesView)
            minesView.resizeView(toY: 0, toWidth: self.view.frame.width, toHeight: self.view.frame.height)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }


}
