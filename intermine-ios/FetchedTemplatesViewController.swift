//
//  FetchedTemplatesViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class FetchedTemplatesViewController: LoadingTableViewController {
    
    var mineUrl: String?
    var params: [String: String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mineUrl = self.mineUrl, let params = self.params {
            IntermineAPIClient.fetchTemplateResults(mineUrl: mineUrl, queryParams: params, completion: { (res) in
                self.stopSpinner()
                // TODO: format result so that it can be shown
                if let results = res?["results"], let headers = res?["columnHeaders"] {
                    //correct headers and merge two arrays into dict
                }
            })
        }
        
        // TODO: in the next view controller implement loading of additional data when tableview is scrolled to bottom
    }
    
    // MARK: Load from storyboard
    
    class func fetchedTemplatesViewController(withMineUrl: String, params: [String: String]) -> FetchedTemplatesViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FetchedTemplatesVC") as? FetchedTemplatesViewController
        vc?.mineUrl = withMineUrl
        vc?.params = params
        return vc
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FetchedTemplateCell.identifier, for: indexPath) as! FetchedTemplateCell
        return cell
    }
    

}
