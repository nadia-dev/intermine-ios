//
//  SearchViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/8/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var selectMineButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar()
        self.descriptionLabel?.text = String.localize("Search.AppDescription")
        self.searchBar?.placeholder = String.localize("Search.Placeholder")
        self.searchBar?.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.selectMineButton?.setTitle(String.localize("Search.SelectMine"), for: .normal)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        let params: [String: String] = self.formParams(query: searchBar.text)
        if let fetchedSearchesVC = FetchedSearchesViewController.fetchedSearchesViewController(withParams: params) {
            self.navigationController?.pushViewController(fetchedSearchesVC, animated: true)
        }
    }
    
    // MARK: Private methods

    private func formParams(query: String?) -> [String: String] {
        var params: [String: String] = ["format": "json", "start": "0", "size": "\(General.searchSize)"]
        if let query = query {
            params["query"] = query
        } else {
            params["query"] = ""
        }
        return params
    }
    
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.barTintColor = Colors.greenMeadow
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = Colors.white
        self.navigationController?.navigationBar.topItem?.title = String.localize("Search.All")
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Colors.white]
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(Icons.menu, for: .normal)
        button.addTarget(self, action: #selector(SearchViewController.menuButtonPressed), for: .touchUpInside)
        button.tintColor = Colors.white
        let barButton = UIBarButtonItem()
        barButton.customView = button
        
        self.navigationItem.leftBarButtonItem = barButton
    }

}
