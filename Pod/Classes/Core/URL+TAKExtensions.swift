//
//  NSURL+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2016 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public extension URL {
  public static func tak_cachesDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return tak_URLForDirectory(.cachesDirectory, domain: domain, url: url, create: create)
  }

  public static func tak_documentDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return tak_URLForDirectory(.documentDirectory, domain: domain, url: url, create: create)
  }
  
  public static func tak_temporaryDirectory() -> URL {
    return URL(fileURLWithPath: NSTemporaryDirectory())
  }

  public func tak_joined(_ paths: String...) -> URL {
    return paths.reduce(self, { $0.appendingPathComponent($1) })
  }

  fileprivate static func tak_URLForDirectory(_ directory: FileManager.SearchPathDirectory, domain: FileManager.SearchPathDomainMask, url: URL?, create: Bool) -> URL {
    return try! FileManager.default.url(for: directory, in: domain, appropriateFor: url, create: create)
  }
}
