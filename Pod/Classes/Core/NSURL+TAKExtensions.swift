//
//  NSURL+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2016 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension NSURL {
  public class func tak_cachesDirectory(domain: NSSearchPathDomainMask = .UserDomainMask, url: NSURL? = nil, create: Bool = true) -> NSURL {
    return tak_URLForDirectory(.CachesDirectory, domain: domain, url: url, create: create)
  }

  public class func tak_documentDirectory(domain: NSSearchPathDomainMask = .UserDomainMask, url: NSURL? = nil, create: Bool = true) -> NSURL {
    return tak_URLForDirectory(.DocumentDirectory, domain: domain, url: url, create: create)
  }
  
  public class func tak_temporaryDirectory() -> NSURL {
    return NSURL(fileURLWithPath: NSTemporaryDirectory())
  }

  public func tak_joined(paths: String...) -> NSURL {
    return paths.reduce(self, combine: { $0.URLByAppendingPathComponent($1)! })
  }

  private class func tak_URLForDirectory(directory: NSSearchPathDirectory, domain: NSSearchPathDomainMask, url: NSURL?, create: Bool) -> NSURL {
    return try! NSFileManager.defaultManager().URLForDirectory(directory, inDomain: domain, appropriateForURL: url, create: create)
  }
}
