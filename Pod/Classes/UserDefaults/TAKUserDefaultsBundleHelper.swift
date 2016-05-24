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

public struct TAKUserDefaultsBundleHelper {
  private struct Const {
    static let Name = "TAKUserDefaults"
    static let Directory = "Frameworks/TAKKitSwift.framework"
  }
  
  public static func bundle() -> NSBundle? {
    if let path = NSBundle.mainBundle().pathForResource(Const.Name, ofType: "bundle", inDirectory: Const.Directory) {
      return NSBundle(path: path)
    }
    return nil
  }
  
  public static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: Const.Name, bundle: bundle())
  }
}
