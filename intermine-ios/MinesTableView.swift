//
//  MinesTableView.swift
//  intermine-ios
//
//  Created by Nadia on 5/10/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class MinesTableView: BaseView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint?
    @IBOutlet weak var verticalCenter: NSLayoutConstraint?
    
    private let itemsCount = CacheDataStore.sharedCacheDataStore.registrySize()
    private let registry = CacheDataStore.sharedCacheDataStore.allRegistry()
    static let minesCell = "MinesCell"
    
    // MARK: Load view
    
    class func loadMinesTableView() -> MinesTableView? {
        return MinesTableView.instantiateFromNib(viewType: MinesTableView.self)
    }
    
    // MARK: Public methods
    
    public func resizeView(toY: CGFloat, toWidth: CGFloat, toHeight: CGFloat) {
        self.frame = CGRect(x: 0, y: toY, width: toWidth, height: toHeight)
        self.layoutIfNeeded()
    }
    
    // MARK: View methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "MinesTableViewCell", bundle: nil), forCellReuseIdentifier: MinesTableView.minesCell)
        self.tableViewHeight?.constant = self.minesTableHeight()
        // TODO: Fix -20 inset
        self.tableView?.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    
    // MARK: Private methods
    
    private func minesTableHeight() -> CGFloat {
        // TODO: Fix on larger sizes of array
        return CGFloat(itemsCount) * General.minesCellHeight
    }

    // MARK: Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinesTableView.minesCell, for: indexPath) as! MinesTableViewCell
        if let registry = registry {
            let mine = registry[indexPath.row]
            cell.mineName = mine.name
            cell.mineColor = mine.theme
            cell.mineUrl = mine.url
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return General.minesCellHeight
    }

}
