//
//  TAKUserDefaultsViewController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

public class TAKUserDefaultsViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var topPaddingConstraint: NSLayoutConstraint!
  private var items: NSDictionary!
  private var keys: NSArray!
  private var filteredKeys: NSArray!
  
  public class func instantiate() -> TAKUserDefaultsViewController? {
    let storyboard = TAKUserDefaultsBundleHelper.storyboard("TAKUserDefaults")
    return storyboard.instantiateViewControllerWithIdentifier("TAKUserDefaultsViewController") as? TAKUserDefaultsViewController
  }
  
  public override func viewDidLoad() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    if navigationController != nil {
      topPaddingConstraint.constant = 0.0
    }
    
    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
      
      if let s = searchDisplayController {
        s.searchResultsTableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
        s.searchResultsTableView.estimatedRowHeight = 108.0
        s.searchResultsTableView.rowHeight = UITableViewAutomaticDimension
      }

    }
  }
  
  public override func viewWillAppear(animated: Bool) {
    items = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()
    keys = items.allKeys.sorted {
      (a, b) -> Bool in
      if let a0 = a as? String {
        if let b0 = b as? String {
          return a0 < b0
        }
      }
      
      return false
    }
    filteredKeys = keys.copy() as NSArray
  }
}

extension TAKUserDefaultsViewController: UITableViewDataSource {
  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return decideKeys(tableView).count
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TAKUserDefaultsViewCell.tak_defaultIdentifier(), forIndexPath: indexPath) as TAKUserDefaultsViewCell
    cell.backgroundColor = tableView.backgroundColor
    
    if let key = decideKeys(tableView)[indexPath.row] as? String {
      if let value: AnyObject = items[key] {
        cell.bind(key, value: value)
      }
    }
    
    return cell
  }
  
  // MARK: - Private Methods
  
  private func decideKeys(tableView: UITableView) -> NSArray {
    if tableView == searchDisplayController?.searchResultsTableView { return filteredKeys }
    return keys
  }
}

extension TAKUserDefaultsViewController: UITableViewDelegate {
  public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

extension TAKUserDefaultsViewController: UISearchDisplayDelegate {
  public func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
    if let predicate = NSPredicate(format: "SELF contains[c] %@", searchString) {
      filteredKeys = keys.filteredArrayUsingPredicate(predicate)
    }
    return true
  }
  
  public func searchDisplayController(controller: UISearchDisplayController, didHideSearchResultsTableView tableView: UITableView) {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }
  
  public func searchDisplayController(controller: UISearchDisplayController, willShowSearchResultsTableView tableView: UITableView) {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if let t = searchDisplayController?.searchResultsTableView {
      t.contentInset = UIEdgeInsetsZero
      t.scrollIndicatorInsets = UIEdgeInsetsZero
    }
  }
}

extension TAKUserDefaultsViewController: UISearchBarDelegate {
}