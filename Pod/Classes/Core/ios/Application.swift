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

public final class Application {
  public static let shared = Application()
  
  public fileprivate(set) var bundleIdentifier = ""
  public fileprivate(set) var version = ""
  public fileprivate(set) var build = ""
  
  fileprivate init() {
    let bundle = Bundle.main
    bundleIdentifier = bundle.bundleIdentifier ?? ""
    version = bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    build = bundle.infoDictionary?["CFBundleVersion"] as? String ?? ""
  }
}
