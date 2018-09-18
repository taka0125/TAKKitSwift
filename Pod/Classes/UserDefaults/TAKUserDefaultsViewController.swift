//
//  TAKUserDefaultsViewController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

final public class TAKUserDefaultsViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!
  
  fileprivate let userDefaults = UserDefaults()
  fileprivate var keys: [String] {
    return userDefaults.allKeys
  }

  fileprivate var searchController: UISearchController
  fileprivate var resultsController: TAKUserDefaultsSearchResultController
  
  public class func instantiate() -> TAKUserDefaultsViewController? {
    let storyboard = TAKUserDefaultsBundleHelper.storyboard()
    return storyboard.tak_instantiateViewController(TAKUserDefaultsViewController.self)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    resultsController = TAKUserDefaultsSearchResultController(userDefaults: userDefaults)
    searchController = UISearchController(searchResultsController: resultsController)
    
    super.init(coder: aDecoder)
  }
  
  public override func viewDidLoad() {
    setupTableView()
    setupResultsController()
    setupSearchController()
    
    tableView.tableHeaderView = searchController.searchBar
    
    definesPresentationContext = true
  }
}

// MARK: - Private Methods

extension TAKUserDefaultsViewController {
  fileprivate func setupResultsController() {
    resultsController.tableView.delegate = self
  }
  
  fileprivate func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.searchBar.sizeToFit()
    searchController.delegate = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    
    if #available(iOS 9.0, *) {
      searchController.loadViewIfNeeded()
    }
  }
  
  fileprivate func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableView.automaticDimension
    
    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
    }
  }
}

extension TAKUserDefaultsViewController: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return keys.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.tak_forceDequeueReusableCell(TAKUserDefaultsViewCell.self, indexPath: indexPath)
    cell.backgroundColor = tableView.backgroundColor
    
    let key = keys[(indexPath as NSIndexPath).row]
    cell.bind(key, value: userDefaults[key])
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension TAKUserDefaultsViewController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

// MARK: - UISearchBarDelegate

extension TAKUserDefaultsViewController: UISearchBarDelegate {
  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

// MARK: - UISearchControllerDelegate

extension TAKUserDefaultsViewController: UISearchControllerDelegate {
}

// MARK: - UISearchResultsUpdating

extension TAKUserDefaultsViewController: UISearchResultsUpdating {
  public func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    
    if let c = self.searchController.searchResultsController as? TAKUserDefaultsSearchResultController {
      c.updateKeys(userDefaults.filteredKeys(searchText))
    }
  }
}
