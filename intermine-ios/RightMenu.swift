//
//  RightMenu.swift
//  intermine-ios
//
//  Created by Nadia on 5/19/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class RightMenu: BaseView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leftView: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint?
    
    var facets: [FacetList]? = [] {
        didSet {
            if let facets = self.facets {
                for f in facets {
                    print(f.getMine())
                    if let sfs = f.getFacets() {
                        for sf in sfs {
                            print(sf.getType())
                            print(sf.getContents())
                        }
                    }
                }
            }
        }
    }

    // MARK: Load from nib
    
    class func rightMenu() -> RightMenu? {
        return self.instantiateFromNib()
    }
    
    // MARK: UIView
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureTableView()
        self.untintBackground()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if let content = self.tableView?.contentSize.height {
            self.tableViewHeight?.constant = content
            // TODO: test this on case with large tables
            if content <= self.frame.size.height {
                self.tableView?.isScrollEnabled = false
            }
        }
    }
    
    // MARK: Private methods
    
    private func configureTableView() {
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "RightMenuCell", bundle: nil), forCellReuseIdentifier: RightMenuCell.identifier)
        self.tableView?.register(UINib(nibName: "RightHeaderCell", bundle: nil), forCellReuseIdentifier: RightHeaderCell.identifier)
    }
    
    // MARK: Public methods
    
    func tintBackground() {
        self.leftView?.alpha = 0.5
    }
    
    func untintBackground() {
        self.leftView?.alpha = 0
    }
    
    // MARK: Table view delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RightMenuCell.identifier, for: indexPath) as! RightMenuCell
        return cell
    }
    
    // MARK: Header view 
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: RightHeaderCell.identifier) as! RightHeaderCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 1))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
