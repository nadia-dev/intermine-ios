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
    
    private let itemsCount = CacheDataStore.sharedCacheDataStore.registrySize()
    static let minesCell = "MinesCell"
    
    // MARK: Load view
    
    class func loadMinesTableView() -> MinesTableView? {
        return MinesTableView.instantiateFromNib(viewType: MinesTableView.self)
    }
    
    // MARK: View methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "MinesTableViewCell", bundle: nil), forCellReuseIdentifier: MinesTableView.minesCell)
        self.tableViewHeight?.constant = self.minesTableHeight()
        // TODO: Fix -20 magic number
        self.tableView?.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    
    // MARK: Private methods
    
    private func minesTableHeight() -> CGFloat {
        return CGFloat(itemsCount) * General.minesCellHeight
    }

    // MARK: Table view data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MinesTableView.minesCell, for: indexPath) as! MinesTableViewCell
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
    
    // MARK: Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }

}
