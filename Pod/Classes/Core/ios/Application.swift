//
//  Application.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public class Application {
  public static let sharedApplication = Application()
  
  public private(set) var bundleIdentifier = ""
  public private(set) var version = ""
  public private(set) var build = ""
  
  private init() {
    let bundle = NSBundle.mainBundle()
    bundleIdentifier = bundle.bundleIdentifier ?? ""
    version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    build = bundle.infoDictionary?["CFBundleVersion"] as? String ?? ""
  }
}