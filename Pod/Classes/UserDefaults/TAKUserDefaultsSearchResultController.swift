//
//  TAKUserDefaultsSearchResultController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

final class TAKUserDefaultsSearchResultController: UITableViewController {
  fileprivate let userDefaults: UserDefaults
  fileprivate var keys: [String]
  
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
  
  func updateKeys(_ keys: [String]) {
    self.keys = keys
    tableView?.reloadData()
  }
}

// MARK: - TableView

extension TAKUserDefaultsSearchResultController {
  fileprivate func setupTableView() {
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableView.automaticDimension
    
    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return keys.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.tak_forceDequeueReusableCell(TAKUserDefaultsViewCell.self, indexPath: indexPath)
    cell.backgroundColor = tableView.backgroundColor
    
    let key = keys[(indexPath as NSIndexPath).row]
    cell.bind(key, value: userDefaults[key])
    
    return cell
  }
}
