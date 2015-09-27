//
//  TAKUserDefaultsSearchResultController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

class TAKUserDefaultsSearchResultController: UITableViewController {
  var filteredKeys: [String]
  
  init() {
    filteredKeys = []
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    filteredKeys = []
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    tableView.estimatedRowHeight = 108.0
    tableView.rowHeight = UITableViewAutomaticDimension

    if let bundle = TAKUserDefaultsBundleHelper.bundle() {
      tableView.tak_registerClassAndNibForCell(TAKUserDefaultsViewCell.self, bundle: bundle)
    }
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredKeys.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(TAKUserDefaultsViewCell.tak_defaultIdentifier(), forIndexPath: indexPath) as! TAKUserDefaultsViewCell
    cell.backgroundColor = tableView.backgroundColor
    
    let key = filteredKeys[indexPath.row]
    
    if let value: AnyObject = TAKUserDefaultsData.sharedInstance.item(key) {
      cell.bind(key, value: value)
    }
    
    return cell
  }
}