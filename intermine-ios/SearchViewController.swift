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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionLabel?.text = String.localize("Search.AppDescription")
        self.searchBar?.placeholder = String.localize("Search.Placeholder")
        self.searchBar?.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func formParams(query: String?) -> [String: String] {
        var params: [String: String] = ["format": "json", "start": "0", "size": "\(General.searchSize)"]
        if let query = query {
            params["query"] = query
        } else {
            params["query"] = ""
        }
        return params
    }

}
