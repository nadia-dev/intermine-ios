//
//  ResultsTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/11/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class ResultsTableViewController: UITableViewController {
    
    private var spinner: NVActivityIndicatorView?
    private var templatesList: TemplatesList? {
        didSet {
            
        }
    }
    
    private var mineUrl: String?
    
    // MARK: Load from storyboard
    
    class func resultsTableViewController(withMineUrl: String) -> ResultsTableViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ResultsTableVC") as? ResultsTableViewController
        vc?.mineUrl = withMineUrl
        return vc
    }

    override func viewDidLoad() {
        //hide table view until info is loaded
        super.viewDidLoad()
        self.configureNavBar()

        self.spinner = NVActivityIndicatorView(frame: self.indicatorFrame(), type: .ballSpinFadeLoader, color: Colors.chelseaCucumber, padding: self.indicatorPadding())
        if let spinner = self.spinner {
            self.view.addSubview(spinner)
            self.view.bringSubview(toFront: spinner)
        }
        self.spinner?.startAnimating()
        if let mineUrl = self.mineUrl {
            IntermineAPIClient.fetchTemplates(mineUrl: mineUrl) { (templatesList) in
                guard let list = templatesList else {
                    self.spinner?.stopAnimating()
                    self.alert(message: String.localize("Results.NotFound"))
                    return
                }
                self.templatesList = list
                self.spinner?.stopAnimating()
            }
        }
    }
    
    // MARK: Private methods
    
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
    
    private func indicatorPadding() -> CGFloat {
        return BaseView.viewWidth(view: self.view) / 2.5
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
