//
//  TemplateDetailTableViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/12/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit


class LookupCell: UITableViewCell {
    
    static let identifier = "LookupCell"
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var lookupTextField: UITextField?
    
    var query: TemplateQuery? {
        didSet {
            lookupTextField?.text = self.query?.getValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.text = "Lookup"
    }
}

protocol OperationSelectionCellDelegate: class {
    func operationSelectionCellDidTapSelectButton(cell: OperationSelectionCell)
}

class OperationSelectionCell: UITableViewCell {
    
    static let identifier = "OperationSelectionCell"
    @IBOutlet weak var operationLabel: UILabel?
    @IBOutlet weak var selectOperationButton: UIButton?
    @IBOutlet weak var valueTextField: UITextField?
    
    weak var delegate: OperationSelectionCellDelegate?
    
    var query: TemplateQuery? {
        didSet {
            operationLabel?.text = self.query?.getOperation()
            valueTextField?.text = self.query?.getValue()
        }
    }
    
    var operation: String? = "==" {
        didSet {
            operationLabel?.text = self.operation
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectOperationButton?.setTitle(String.localize("Templates.CTA.SelectOperation"), for: .normal)
        selectOperationButton?.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        selectOperationButton?.titleLabel?.numberOfLines = 2
        selectOperationButton?.titleLabel?.textAlignment = NSTextAlignment.center
        NotificationCenter.default.addObserver(self, selector: #selector(self.operationChanged(_:)), name: NSNotification.Name(rawValue: Notifications.operationChanged), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func operationSelectButtonTapped(_ sender: Any) {
        self.delegate?.operationSelectionCellDidTapSelectButton(cell: self)
    }
    
    // MARK: Notification when operation is changed
    
    func operationChanged(_ notification: NSNotification) {
        if let op = notification.userInfo?["op"] as? String {
            self.query?.changeOperation(operation: op)
            operationLabel?.text = op
        }
    }
}

class DescriptionCell: UITableViewCell {
    
    static let identifier = "DescripitonCell"
    @IBOutlet weak var descriptionLabel: UILabel?
    
    var info: String? = "" {
        didSet {
            descriptionLabel?.text = self.info
        }
    }
    
}

class ActionCell: UITableViewCell {
    
    static let identifier = "ActionCell"
    @IBOutlet weak var searchButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchButton?.setTitle(String.localize("Templates.CTA.Search"), for: .normal)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        // NETWORK CALL with built query
    }
    
}


class TemplateDetailTableViewController: UITableViewController, OperationSelectionCellDelegate, OperationSelectViewControllerDelegate {
    
    private var sortedQueries: [TemplateQuery] = []
    private var switchIndex: Int = 0
    private var popover: OperationSelectViewController?
    
    var template: Template? {
        didSet {
            self.tableView.reloadData()
            if let template = self.template {
                self.sortedQueries = template.getQueriesSortedByType()
                self.switchIndex = template.opQueryCount() - 1
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
        if (indexPath.row < switchIndex) || (indexPath.row == 0 && switchIndex == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: LookupCell.identifier, for: indexPath) as! LookupCell
            cell.query = sortedQueries[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OperationSelectionCell.identifier, for: indexPath) as! OperationSelectionCell
            cell.query = sortedQueries[indexPath.row]
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }

    // MARK: Operation selection cell delegate
    
    func operationSelectionCellDidTapSelectButton(cell: OperationSelectionCell) {
        if let popover = OperationSelectViewController.operationSelectViewController() {
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
    
    // MARK: Notification when operation is changed
    
    func operationChanged(_ notification: NSNotification) {
        if let op = notification.userInfo?["op"] as? String {
            // change query in list of queries according to index of the cell
//            self.query?.changeOperation(operation: op)
//            operationLabel?.text = op
        }
    }

    
    
}
