//
//  SearchRefineViewController.swift
//  intermine-ios
//
//  Created by Nadia on 5/20/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    static let identifier = "CategoryCell"
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var countLabel: UILabel?
    
    
}

class RefineSearchViewController: BaseViewController, UISearchResultsUpdating, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private var mines: [String] = [String.localize("Search.Refine.NoSelection")]
    private var categoryFacets: [SearchFacet]?
    
    private var facets: [FacetList]? {
        didSet {
            self.mines = self.listMineNames()
        }
    }
    
    @IBOutlet weak var minesLabel: UILabel?
    @IBOutlet weak var categoriesLabel: UILabel?
    
    @IBOutlet weak var minesPicker: UIPickerView?
    @IBOutlet weak var categoriesTable: UITableView?
    
    @IBOutlet weak var closeButton: UIButton?
    
    
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchController()
        minesLabel?.text = String.localize("Search.Refine.SelectMine")
        categoriesLabel?.text = String.localize("Search.Refine.SelectCategory")
        minesPicker?.delegate = self
        minesPicker?.dataSource = self
        categoriesTable?.delegate = self
        categoriesTable?.dataSource = self
        minesPicker?.selectRow(self.getInitialSelectedRow(), inComponent: 0, animated: false)
        closeButton?.setImage(Icons.close, for: .normal)
    }
    
    // MARK: Private methods
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        categoriesTable?.tableHeaderView = searchController.searchBar
    }
    
    private func listMineNames() -> [String] {
        guard let facets = self.facets else {
            return self.mines
        }
        
        var mineNames: [String] = self.mines
        for facet in facets {
            print(facet)
            if let name = facet.getMine() {
                if !(mineNames.contains(name)) {
                    mineNames.append(name)
                }
            }
        }
        return mineNames
    }
    
    private func getMinesCount() -> Int {
        return mines.count
    }
    
    private func getInitialSelectedRow() -> Int {
        return self.getMinesCount()/2
    }


    // MARK: Action

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Load from storyboard
    
    class func refineSearchViewController(withFacets: [FacetList]?) -> RefineSearchViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RefineSearchVC") as? RefineSearchViewController
        vc?.facets = withFacets
        return vc
    }
    
    // MARK: UISearchResultsUpdating delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        // To implement
    }
    
    // MARK: Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.getMinesCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mines[row]
    }
    
    // MARK: Picker view delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // To implement
    }
    
    // MARK: - Table view data source
    
    // TODO: this needs to be in sync w/mine selection from picker
    // when certain mine is selected in picker -->
    // table view shows categories for this mine
    // when different mine is selected -->
    // table view reloads
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        return cell
    }

}
