//
//  NSNotification+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension Notification {
  fileprivate struct Const {
    static let Key = "tak_parameters"
  }
}

extension Notification: TAKKitCompatible {}

extension TAKKit where Base == Notification {
  public var parameters: Any? {
    return base.userInfo?[Base.Const.Key]
  }
  
  public static func notification(_ identifier: String, object: Any? = nil, parameters: Any? = nil) -> Notification {
    return notification(Notification.Name(rawValue: identifier), object: object, parameters: parameters)
  }
  
  public static func notification(_ name: Notification.Name, object: Any? = nil, parameters: Any? = nil) -> Notification {
    var userInfo: [AnyHashable: Any]? = nil
    if let parameters = parameters {
      userInfo = [Base.Const.Key: parameters]
    }
    return Notification(name: name, object: object, userInfo: userInfo)
  }
}


// deprecated //

public extension Notification {
  @available(*, deprecated, renamed: "tak.parameters")
  public var tak_parameters: Any? {
    return tak.parameters
  }
  
  @available(*, deprecated, renamed: "tak.notification(identifier:object:parameters:)")
  public static func tak_notification(_ identifier: String, object: Any? = nil, parameters: Any? = nil) -> Notification {
    return TAKKit.notification(identifier, object: object, parameters: parameters)
  }
  
  @available(*, deprecated, renamed: "tak.notification(name:object:parameters:)")
  public static func tak_notification(_ name: Notification.Name, object: Any? = nil, parameters: Any? = nil) -> Notification {
    return TAKKit.notification(name, object: object, parameters: parameters)
  }
}


