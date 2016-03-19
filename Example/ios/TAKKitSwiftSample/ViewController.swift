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

class ViewController: UITableViewController, ControllerInstantiatable {
  static let storyboardName = "Main"
  var value1 = 0
  
  private enum Row: NSInteger {
    case RunInBackground = 0
    case RunOnMainThread
    case ShowAlert
    case UsersDefault
    case Instantiatable
    case Application
    case PhotoSelector
    case Keyboard
    case NSURLSample
  }
  
  override func viewWillAppear(animated: Bool) {
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if let row = Row(rawValue: indexPath.row) {
      switch row {
      case .RunInBackground:
        runInBackground()
      case .RunOnMainThread:
        runOnMainThread()
      case .ShowAlert:
        showAlert()
      case .UsersDefault:
        showUsersDefault()
      case .Instantiatable:
        let c = ViewController.createInstance()
        print(c)
      case .Application:
        showApplicationInfo()
      case .NSURLSample:
        doNSURLSample()
      default:
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
      }
    }
  }
}

extension ViewController {
  private func runInBackground() {
    TAKBlock.runInBackground {
      print("isMainThread = \(NSThread.currentThread().isMainThread)")
    }
  }
  
  private func runOnMainThread() {
    TAKBlock.runOnMainThread {
      print("isMainThread = \(NSThread.currentThread().isMainThread)")
    }
  }
  
  private func showAlert() {
    TAKAlert.show("Alert")
  }
  
  private func showUsersDefault() {
    if let c = TAKUserDefaultsViewController.instantiate() {
      navigationController?.pushViewController(c, animated: true)
    }
  }
  
  private func showApplicationInfo() {
    print("bundleIdentifier = \(Application.sharedApplication.bundleIdentifier)")
    print("version = \(Application.sharedApplication.version)")
    print("build = \(Application.sharedApplication.build)")
  }
  
  private func doNSURLSample() {
    let cachesDirectory = NSURL.tak_cachesDirectory()
    let documentDirectory = NSURL.tak_documentDirectory()
    let temporaryDirectory = NSURL.tak_temporaryDirectory()
    
    print(cachesDirectory)
    print(documentDirectory)
    print(temporaryDirectory)
    print(temporaryDirectory.tak_joined("foo", "bar", "fuga.txt"))
  }
}
