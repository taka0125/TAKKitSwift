//
//  NSNotificationCenter+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

extension NotificationCenter: TAKKitCompatible { }

extension TAKKit where Base == NotificationCenter {
  public func replaceObserver(_ notificationObserver: AnyObject, selector: Selector, identifier: String, object: Any? = nil) {
    replaceObserver(notificationObserver, selector: selector, name: Notification.Name(rawValue: identifier), object: object)
  }
  
  public func replaceObserver(_ notificationObserver: AnyObject, selector: Selector, name: Notification.Name, object: Any? = nil) {
    base.removeObserver(notificationObserver, name: name, object: object)
    base.addObserver(notificationObserver, selector: selector, name: name, object: object)
  }
}

public extension NotificationCenter {
  @available(*, deprecated, renamed: "tak.replaceObserver(notificationObserver:selector:identifier:object:)")
  public func tak_replaceObserver(_ notificationObserver: AnyObject, selector: Selector, identifier: String, object: Any? = nil) {
    tak.replaceObserver(notificationObserver, selector: selector, identifier: identifier, object: object)
  }
  
  @available(*, deprecated, renamed: "tak.replaceObserver(notificationObserver:selector:name:object:)")
  public func tak_replaceObserver(_ notificationObserver: AnyObject, selector: Selector, name: Notification.Name, object: Any? = nil) {
    tak.replaceObserver(notificationObserver, selector: selector, name: name, object: object)
  }
}
