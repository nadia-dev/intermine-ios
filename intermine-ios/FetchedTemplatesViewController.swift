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
    
    var templates: [[String: String]] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let mineUrl = self.mineUrl, let params = self.params {
            IntermineAPIClient.fetchTemplateResults(mineUrl: mineUrl, queryParams: params, completion: { (res) in
                if let results = res?["results"] as? NSArray, let headers = res?["columnHeaders"] as? NSArray {
                    let processedHeaders = self.processHeaderArray(headerArray: headers)
                    for res in results {
                        if let res = res as? [String] {
                            let dict = Dictionary(keys: processedHeaders, values: res)
                            self.templates.append(dict)
                        }
                    }
                }
                self.stopSpinner()
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
    
    // MARK: Private methods

    private func processHeaderArray(headerArray: NSArray) -> [String] {
        var processedArray: [String] = []
        for elem in headerArray {
            if let elem = elem as? String {
                let comps = elem.components(separatedBy: " > ")
                if comps.count > 1 {
                    let title = comps[1]
                    processedArray.append(title)
                }
            }
        }
        return processedArray
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.templates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FetchedTemplateCell.identifier, for: indexPath) as! FetchedTemplateCell
        cell.template = templates[indexPath.row]
        return cell
    }
    

}
