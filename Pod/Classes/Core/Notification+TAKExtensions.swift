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
  
  public var tak_parameters: Any? {
    return userInfo?[Const.Key]
  }
  
  public static func tak_notification(_ identifier: String, object: Any? = nil, parameters: Any? = nil) -> Notification {
    return tak_notification(Notification.Name(rawValue: identifier), object: object, parameters: parameters)
  }
  
  public static func tak_notification(_ name: Notification.Name, object: Any? = nil, parameters: Any? = nil) -> Notification {
    var userInfo: [AnyHashable: Any]? = nil
    if let parameters = parameters {
      userInfo = [Const.Key: parameters]
    }
    
    return Notification(name: name, object: object, userInfo: nil)
  }
}
