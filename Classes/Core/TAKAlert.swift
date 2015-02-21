//
//  TAKAlert.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public class TAKAlert {
  public class func show(title: String = "", message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default, handler: nil)
    alert.addAction(okAction)
    
    if let window = UIApplication.sharedApplication().delegate?.window? {
      if let c = findTopViewController(window.rootViewController) {
        TAKBlock.runOnMainThread {
          c.presentViewController(alert, animated: true, completion: nil)
        }
      }
    }
  }
  
  private class func findTopViewController(rootViewController: UIViewController?) -> UIViewController? {
    if let r = rootViewController {
      switch r {
      case let c as UITabBarController:
        return findTopViewController(c.selectedViewController)
      case let c as UINavigationController:
        return findTopViewController(c.visibleViewController)
      default:
        if let c = r.presentedViewController {
          return findTopViewController(c)
        }
        
        return r
      }
    } else {
      return nil
    }
  }
}