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

public class TAKUserDefaultsViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  
  private var searchController: UISearchController
  private var resultsController: TAKUserDefaultsSearchResultController
  private var keys: [String]
  
  public class func instantiate() -> TAKUserDefaultsViewController? {
    let storyboard = TAKUserDefaultsBundleHelper.storyboard("TAKUserDefaults")
    return storyboard.instantiateViewControllerWithIdentifier("TAKUserDefaultsViewController") as? TAKUserDefaultsViewController
  }
  
  public required init?(coder aDecoder: NSCoder) {
    let data = TAKUserDefaultsData.sharedInstance
    data.load()
    
    keys = data.allKeys
    resultsController = TAKUserDefaultsSearchResultController()
    
    searchController = UISearchController(searchResultsController: resultsController)
    
    super.init(coder: aDecoder)
  }
  
  public override func viewDidLoad() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
    }
    
    resultsController.tableView.delegate = self
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.sizeToFit()
    searchController.delegate = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    
    if #available(iOS 9.0, *) {
      searchController.loadViewIfNeeded()
    }
    
    tableView.tableHeaderView = searchController.searchBar
    
    definesPresentationContext = true
  }
}

extension TAKUserDefaultsViewController: UITableViewDataSource {
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return keys.count
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TAKUserDefaultsViewCell.tak_defaultIdentifier(), forIndexPath: indexPath) as! TAKUserDefaultsViewCell
    cell.backgroundColor = tableView.backgroundColor
    
    let key = keys[indexPath.row]
    if let value: AnyObject = TAKUserDefaultsData.sharedInstance.item(key) {
      cell.bind(key, value: value)
    }
    
    return cell
  }
}

// MARK: - UITableViewDelegate

extension TAKUserDefaultsViewController: UITableViewDelegate {
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - UISearchBarDelegate

extension TAKUserDefaultsViewController: UISearchBarDelegate {
  public func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

// MARK: - UISearchControllerDelegate

extension TAKUserDefaultsViewController: UISearchControllerDelegate {
}

// MARK: - UISearchResultsUpdating

extension TAKUserDefaultsViewController: UISearchResultsUpdating {
  public func updateSearchResultsForSearchController(searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    
    if let c = self.searchController.searchResultsController as? TAKUserDefaultsSearchResultController {
      c.filteredKeys = TAKUserDefaultsData.sharedInstance.filteredKeys(searchText)
      c.tableView.reloadData()
    }
  }
}