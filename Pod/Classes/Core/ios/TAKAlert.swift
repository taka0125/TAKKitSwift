//
//  TAKAlert.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public class TAKAlert {
  public class func show(message: String) {
    show("", message: message)
  }
  
  public class func show(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default, handler: nil)
    alert.addAction(okAction)
    
    if let w = UIApplication.sharedApplication().delegate?.window, window = w {
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
    }
    return nil
  }
}