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

public struct TAKAlert {
  public static func show(message: String) {
    show("", message)
  }
  
  public static func show(title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .Default, handler: nil)
    alert.addAction(okAction)
    
    if let w = UIApplication.sharedApplication().delegate?.window, window = w {
      if let c = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          c.presentViewController(alert, animated: true, completion: nil)
        }
      }
    }
  }
}