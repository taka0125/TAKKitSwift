//
//  TAKUserDefaultsSearchResultController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

final class TAKUserDefaultsSearchResultController: UITableViewController {
  private let userDefaults: UserDefaults
  private var keys: [String]
  
  init(userDefaults: UserDefaults) {
    keys = []
    self.userDefaults = userDefaults
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    keys = []
    self.userDefaults = UserDefaults()
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    setupTableView()
  }
  
  func updateKeys(keys: [String]) {
    self.keys = keys
    tableView?.reloadData()
  }
}

// MARK: - TableView

extension TAKUserDefaultsSearchResultController {
  private func setupTableView() {
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableViewAutomaticDimension
    
    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return keys.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.tak_forceDequeueReusableCell(TAKUserDefaultsViewCell.self, indexPath: indexPath)
    cell.backgroundColor = tableView.backgroundColor
    
    let key = keys[indexPath.row]
    cell.bind(key, value: userDefaults[key])
    
    return cell
  }
}
