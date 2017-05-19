//
//  AllSearchesViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/17/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FetchedSearchesViewController: LoadingTableViewController {
    
    private var currentOffset: Int = 0
    private var params: [String: String]?
    
    private var data: [[String: String]] = [] {
        didSet {
            if data.count > 0 {
                self.tableView.reloadData()
                self.hideNothingFoundView()
            } else {
                self.showNothingFoundView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = Colors.pistachio
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = Colors.white
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = String.localize("Search.Search")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.white]
        self.loadTemplateResultsWithOffset(offset: self.currentOffset)
    }
    
    // MARK: Load from storyboard
    
    class func fetchedSearchesViewController(withParams: [String: String]?) -> FetchedSearchesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FetchedSearchVC") as? FetchedSearchesViewController
        vc?.params = withParams
        return vc
    }
    
    // MARK: Private methods
    
    private func loadTemplateResultsWithOffset(offset: Int) {
        self.params?["start"] = "\(offset)"
        if let params = self.params {
            IntermineAPIClient.makeSearchOverAllMines(params: params) { (searchResults) in
                // Transform into [String: String] dict
                if let searchResults = searchResults {
                    for res in searchResults {
                        self.data.append(res.viewableRepresentation())
                        self.stopSpinner()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FetchedCell.identifier, for: indexPath) as! FetchedCell
        cell.data = self.data[indexPath.row]
        return cell
    }


}
