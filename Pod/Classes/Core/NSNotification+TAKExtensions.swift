//
//  NSNotification+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension NSNotification {
  private struct Const {
    static let Key = "tak_parameters"
  }
  
  public var tak_parameters: AnyObject? {
    return userInfo?[Const.Key]
  }
  
  public class func tak_notification(name: String) -> NSNotification {
    return tak_notification(name, object: nil, parameters: nil)
  }
  
  public class func tak_notification(name: String, parameters: AnyObject) -> NSNotification {
    return tak_notification(name, object: nil, parameters: parameters)
  }
  
  public class func tak_notification(name: String, object: AnyObject?, parameters: AnyObject?) -> NSNotification {
    var userInfo: [NSObject: AnyObject]? = nil
    if let parameters: AnyObject = parameters {
      userInfo = [Const.Key: parameters]
    }
    return NSNotification(name: name, object: object, userInfo: userInfo)
  }
}
