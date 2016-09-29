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
  public static func show(_ message: String) {
    show("", message)
  }
  
  public static func show(_ title: String, _ message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
    alert.addAction(okAction)
    
    if let w = UIApplication.shared.delegate?.window, let window = w {
      if let c = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          c.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
}
