//
//  NSObject+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension NSObject {
  public class func tak_defaultIdentifier() -> String {
    return NSStringFromClass(self).componentsSeparatedByString(".").last!
  }
}
