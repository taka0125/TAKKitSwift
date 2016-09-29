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
  fileprivate struct Const {
    static let Name = "TAKUserDefaults"
    static let Directory = "Frameworks/TAKKitSwift.framework"
  }
  
  public static func bundle() -> Bundle? {
    if let path = Bundle.main.path(forResource: Const.Name, ofType: "bundle", inDirectory: Const.Directory) {
      return Bundle(path: path)
    }
    return nil
  }
  
  public static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: Const.Name, bundle: bundle())
  }
}
