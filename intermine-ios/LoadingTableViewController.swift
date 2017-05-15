//
//  LoadingTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingTableViewController: UITableViewController {
    
    private var spinner: NVActivityIndicatorView?
    private var nothingFoundView: BaseView? = nil
    
    var mineUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavBar()
        
        self.nothingFoundView = TableCoverView.instantiateFromNib()
        if let nothingFoundView = self.nothingFoundView {
            nothingFoundView.frame = self.tableView.frame
            self.tableView.addSubview(nothingFoundView)
            nothingFoundView.isHidden = true
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.spinner = NVActivityIndicatorView(frame: self.indicatorFrame(), type: .ballGridPulse, color: Colors.chelseaCucumber, padding: self.indicatorPadding())
        if let spinner = self.spinner {
            self.view.addSubview(spinner)
            self.view.bringSubview(toFront: spinner)
        }
        self.spinner?.startAnimating()
    }
    
    func stopSpinner() {
        self.spinner?.stopAnimating()
    }
    
    func showNothingFoundView() {
        self.nothingFoundView?.isHidden = false
    }
    
    func hideNothingFoundView() {
        self.nothingFoundView?.isHidden = true
    }
    
    private func indicatorFrame() -> CGRect {
        if let navbarHeight = self.navigationController?.navigationBar.frame.size.height, let tabbarHeight = self.tabBarController?.tabBar.frame.size.height {
            let viewHeight = BaseView.viewHeight(view: self.view)
            let indicatorHeight = viewHeight - (tabbarHeight + navbarHeight)
            let indicatorWidth = BaseView.viewWidth(view: self.view)
            return CGRect(x: 0, y: 0, width: indicatorWidth, height: indicatorHeight)
        } else {
            return self.view.frame
        }
    }
    
    private func configureNavBar() {
        guard let url = self.mineUrl else {
            return
        }
        if let mine = CacheDataStore.sharedCacheDataStore.findMineByUrl(url: url) {
            self.navigationController?.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: mine.theme)
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.tintColor = Colors.white
            self.navigationController?.navigationBar.backItem?.title = ""
            self.navigationController?.navigationBar.topItem?.title = mine.name
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.white]
        }
    }
    
    private func indicatorPadding() -> CGFloat {
        return BaseView.viewWidth(view: self.view) / 2.5
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // To override
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // To override
        return 0
    }
}
