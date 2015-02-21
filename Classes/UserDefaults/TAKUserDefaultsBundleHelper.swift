//
//  TAKUserDefaultsBundleHelper.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public class TAKUserDefaultsBundleHelper {
  private struct Const {
    static let Name = "TAKUserDefaults"
    static let Directory = "Frameworks/TAKKitSwift.framework"
  }
  
  public class func bundle() -> NSBundle? {
    if let path = NSBundle.mainBundle().pathForResource(Const.Name, ofType: "bundle", inDirectory: Const.Directory) {
      return NSBundle(path: path)
    } else {
      return nil
    }
  }
  
  public class func storyboard(name: String) -> UIStoryboard {
    return UIStoryboard(name: name, bundle: bundle())
  }
}