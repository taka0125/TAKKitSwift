//
//  NSNotificationCenter+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension NotificationCenter {
  public func tak_replaceObserver(_ notificationObserver: AnyObject, selector: Selector, identifier: String, object: Any? = nil) {
    tak_replaceObserver(notificationObserver, selector: selector, name: Notification.Name(rawValue: identifier), object: object)
  }
  
  public func tak_replaceObserver(_ notificationObserver: AnyObject, selector: Selector, name: Notification.Name, object: Any? = nil) {
    removeObserver(notificationObserver, name: name, object: object)
    addObserver(notificationObserver, selector: selector, name: name, object: object)
  }
}
