//
//  TemplateDetailTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit


class TemplateDetailTableViewController: UITableViewController, OperationSelectionCellDelegate, OperationSelectViewControllerDelegate, ActionCellDelegate {
    
    private var sortedQueries: [TemplateQuery] = []
    private var switchIndex: Int = 0
    private var popover: OperationSelectViewController?
    
    var template: Template? {
        didSet {
            self.tableView.reloadData()
            if let template = self.template {
                self.sortedQueries = template.getQueriesSortedByType()
                self.switchIndex = template.totalQueryCount() - template.opQueryCount() - 1
            }
        }
    }
    
    // MARK: Load from storyboard
    
    class func templateDetailTableViewController(withTemplate: Template) -> TemplateDetailTableViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TemplateDetailVC") as? TemplateDetailTableViewController
        vc?.template = withTemplate
        return vc
    }
    
    // MARK: View controller methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        self.tableView.estimatedSectionHeaderHeight = 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.operationChanged(_:)), name: NSNotification.Name(rawValue: Notifications.operationChanged), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.valueChanged(_:)), name: NSNotification.Name(rawValue: Notifications.valueChanged), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedQueries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row < switchIndex) || (indexPath.row == 0 && switchIndex == 0) || (switchIndex == -1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: LookupCell.identifier, for: indexPath) as! LookupCell
            cell.query = sortedQueries[indexPath.row]
            cell.index = indexPath.row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OperationSelectionCell.identifier, for: indexPath) as! OperationSelectionCell
            cell.query = sortedQueries[indexPath.row]
            cell.index = indexPath.row
            cell.delegate = self
            return cell
        }
    }
    
    // MARK: Header and footer
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier) as! DescriptionCell
        cell.info = template?.getInfo()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActionCell.identifier) as! ActionCell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }

    // MARK: Operation selection cell delegate
    
    func operationSelectionCellDidTapSelectButton(cell: OperationSelectionCell) {
        let ip = self.tableView.indexPath(for: cell)
        if let popover = OperationSelectViewController.operationSelectViewController(forCellIndex: ip?.row) {
            popover.modalPresentationStyle = UIModalPresentationStyle.popover
            popover.delegate = self
            self.popover = popover
            self.present(popover, animated: true, completion: nil)
        }
    }
    
    // MARK: Operation select view controller delegate
    
    func operationSelectViewControllerDidTapClose(controller: OperationSelectViewController) {
        self.popover?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Action cell delegate
    
    func actionCellDidTapSearchButton(actionCell: ActionCell) {
        // TODO: - collect values from text fields
        
        
        guard let template = self.template else {
            return
        }
        var gen = 0
        var params = ["name": template.getName(), "start": "0", "size": "15", "format": "json"]
        //TODO: in the next view controller implement loading of additional data when tableview is scrolled to bottom
        
        for query in self.sortedQueries {
            gen += 1
            let queryParams = query.constructDictForGen(gen: gen)
            params.update(other: queryParams)
        }
        
        print(params)
        
        if let mineUrl = self.template?.getMineUrl() {
            IntermineAPIClient.fetchTemplateResults(mineUrl: mineUrl, queryParams: params)
        }
    }
    
    // MARK: Notification when operation is changed
    
    func operationChanged(_ notification: NSNotification) {
        if let op = notification.userInfo?["op"] as? String, let index = notification.userInfo?["index"] as? Int {
            let updatedQuery = self.sortedQueries[index]
            updatedQuery.changeOperation(operation: op)
        }
    }
    
    // MARK: Notification when value is changed
    
    func valueChanged(_ notification: NSNotification) {
        if let value = notification.userInfo?["value"] as? String, let index = notification.userInfo?["index"] as? Int {
            let updatedQuery = self.sortedQueries[index]
            updatedQuery.changeValue(value: value)
        }
    }

}
