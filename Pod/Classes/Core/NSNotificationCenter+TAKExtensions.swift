//
//  NSNotificationCenter+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public protocol NotificationName {
  var rawValue: String { get }
}

public extension NSNotificationCenter {
  public func tak_replaceObserver(notificationObserver: AnyObject, selector: Selector, name: NotificationName, object: AnyObject? = nil) {
    tak_replaceObserver(notificationObserver, selector: selector, name: name.rawValue, object: object)
  }
  
  public func tak_replaceObserver(notificationObserver: AnyObject, selector: Selector, name: String, object: AnyObject? = nil) {
    removeObserver(notificationObserver, name: name, object: object)
    addObserver(notificationObserver, selector: selector, name: name, object: object)
  }
}
