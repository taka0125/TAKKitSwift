//
//  ViewController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import TAKKitSwift

class ViewController: UITableViewController {
  private enum Row: NSInteger {
    case RunInBackground = 0, RunOnMainThread, UsersDefault
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if let row = Row(rawValue: indexPath.row) {
      switch row {
      case .RunInBackground:
        runInBackground()
      case .RunOnMainThread:
        runOnMainThread()
      case .UsersDefault:
        showUsersDefault()
      }
    }
  }
  
  private func runInBackground() {
    TAKBlock.runInBackground {
      println("isMainThread = \(NSThread.currentThread().isMainThread)")
    }
  }
  
  private func runOnMainThread() {
    TAKBlock.runOnMainThread {
      println("isMainThread = \(NSThread.currentThread().isMainThread)")
    }
  }
  
  private func showUsersDefault() {
    if let c = TAKUserDefaultsViewController.instantiate() {
      navigationController?.pushViewController(c, animated: true)
    }
  }
}

