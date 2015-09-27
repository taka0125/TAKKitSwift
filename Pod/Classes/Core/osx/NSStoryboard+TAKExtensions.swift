//
//  NSStoryboard+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import AppKit

public extension NSStoryboard {
  public func tak_instantiateViewController<T: NSWindowController>(klass: T.Type) -> T? {
    return instantiateControllerWithIdentifier(T.tak_defaultIdentifier()) as? T
  }

  public func tak_instantiateViewController<T: NSViewController>(klass: T.Type) -> T? {
    return instantiateControllerWithIdentifier(T.tak_defaultIdentifier()) as? T
  }
}
