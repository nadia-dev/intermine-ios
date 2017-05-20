//
//  AllSearchesViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/17/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FetchedSearchesViewController: LoadingTableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var refineButton: UIButton?
    @IBOutlet weak var buttonView: UIView?
    
    private var currentOffset: Int = 0
    private var params: [String: String]?
    private var drawer: RightMenu?
    
    private var data: [[String: String]] = [] {
        didSet {
            if data.count > 0 {
                self.tableView.reloadData()
                self.hideNothingFoundView()
                self.buttonView?.isHidden = false
            } else {
                self.showNothingFoundView()
                self.buttonView?.isHidden = true
            }
        }
    }
    
    // MARK: View controller methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavbar()
        self.loadTemplateResultsWithOffset(offset: self.currentOffset)
        refineButton?.setTitle(String.localize("Search.Refine"), for: .normal)
        buttonView?.isHidden = true
        self.drawer = RightMenu.rightMenu()
        if let drawer = self.drawer {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            drawer.addGestureRecognizer(tap)
            if let tabBarHeigh = self.tabBarController?.tabBar.frame.size.height {
                drawer.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height - tabBarHeigh)
                self.view.addSubview(drawer)
            }
        }
    }
    
    // MARK: Load from storyboard
    
    class func fetchedSearchesViewController(withParams: [String: String]?) -> FetchedSearchesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FetchedSearchVC") as? FetchedSearchesViewController
        vc?.params = withParams
        return vc
    }
    
    // MARK: Private methods
    
    private func configureNavbar() {
        self.navigationController?.navigationBar.barTintColor = Colors.pistachio
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = Colors.white
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.topItem?.title = String.localize("Search.Search")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.white]
    }
    
    private func loadTemplateResultsWithOffset(offset: Int) {
        self.params?["start"] = "\(offset)"
        if let params = self.params {
            IntermineAPIClient.makeSearchOverAllMines(params: params) { (searchResults, facetLists) in
                // Transform into [String: String] dict
                if let searchResults = searchResults {
                    for res in searchResults {
                        self.data.append(res.viewableRepresentation())
                        self.stopSpinner()
                    }
                }
                
                if let facets = facetLists {
                    self.drawer?.facets = facets
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
    
    // MARK: Action
    
    @IBAction func refineButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.drawer?.frame.origin.x = 0
        }) { (done) in
            self.tableView.isScrollEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                self.drawer?.tintBackground()
            }, completion: nil)
        }
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.1, animations: {
            self.drawer?.untintBackground()
        }) { (done) in
            UIView.animate(withDuration: 0.3, animations: {
                self.drawer?.frame.origin.x = self.view.frame.width
            }, completion: { (done) in
                self.tableView.isScrollEnabled = true
            })
        }
    }
}
