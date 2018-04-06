//
//  NSObject+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

internal extension NSObject {
  internal class func tak_defaultIdentifier() -> String {
    return NSStringFromClass(self).components(separatedBy: ".").last!
  }
}
