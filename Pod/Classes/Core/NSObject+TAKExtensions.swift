//
//  NSObject+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

extension NSObject: TAKKitCompatible { }

extension TAKKit where Base: NSObject {
  public class var defaultIdentifier: String {
    return NSStringFromClass(Base.self).components(separatedBy: ".").last!
  }
}

public extension NSObject {
  @available(*, deprecated, renamed: "tak.defaultIdentifier")
  public class func tak_defaultIdentifier() -> String {
    return tak.defaultIdentifier
  }
}
