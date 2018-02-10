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
  
  fileprivate var decimation = Decimation(interval: 1.0)
  
  fileprivate enum Row: NSInteger {
    case runInBackground = 0
    case runOnMainThread
    case showAlert
    case userDefaults
    case instantiatable
    case application
    case photoSelector
    case keyboard
    case nsurlSample
    case decimation
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
        
    if let row = Row(rawValue: indexPath.row) {
      switch row {
      case .runInBackground:
        runInBackground()
      case .runOnMainThread:
        runOnMainThread()
      case .showAlert:
        showAlert()
      case .userDefaults:
        showUserDefaults()
      case .instantiatable:
        let c = ViewController.makeInstance()
        print(c as Any)
      case .application:
        showApplicationInfo()
      case .nsurlSample:
        doNSURLSample()
      case .decimation:
        doDecimationSample()
      default:
        return
      }
    }
  }
}

extension ViewController {
  fileprivate func runInBackground() {
    TAKBlock.runInBackground {
      print("isMainThread = \(Thread.current.isMainThread)")
    }
  }
  
  fileprivate func runOnMainThread() {
    TAKBlock.runOnMainThread {
      print("isMainThread = \(Thread.current.isMainThread)")
    }
  }
  
  fileprivate func showAlert() {
    TAKAlert.show("Alert")
  }
  
  fileprivate func showUserDefaults() {
    if let c = TAKUserDefaultsViewController.instantiate() {
      navigationController?.pushViewController(c, animated: true)
    }
  }
  
  fileprivate func showApplicationInfo() {
    print("bundleIdentifier = \(Application.shared.bundleIdentifier)")
    print("version = \(Application.shared.version)")
    print("build = \(Application.shared.build)")
  }
  
  fileprivate func doNSURLSample() {
    let cachesDirectory = URL.tak_cachesDirectory()
    let documentDirectory = URL.tak_documentDirectory()
    let temporaryDirectory = URL.tak_temporaryDirectory()
    
    print(cachesDirectory)
    print(documentDirectory)
    print(temporaryDirectory)
    print(temporaryDirectory.tak_joined("foo", "bar", "fuga.txt"))
  }
  
  fileprivate func doDecimationSample() {
    (1...5).forEach { i in
      decimation.execute {
        print(i)
      }
    }
    print("done")
  }
}
