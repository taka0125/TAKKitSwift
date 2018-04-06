//
//  NSURL+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2016 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

extension URL: TAKKitCompatible {}

extension TAKKit where Base == URL {
  public static func cachesDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return URLForDirectory(.cachesDirectory, domain: domain, url: url, create: create)
  }
  
  public static func documentDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return URLForDirectory(.documentDirectory, domain: domain, url: url, create: create)
  }
  
  public static var temporaryDirectory: URL {
    return URL(fileURLWithPath: NSTemporaryDirectory())
  }
  
  public func joined(_ paths: String...) -> URL {
    return paths.reduce(base, { $0.appendingPathComponent($1) })
  }
  
  fileprivate static func URLForDirectory(_ directory: FileManager.SearchPathDirectory, domain: FileManager.SearchPathDomainMask, url: URL?, create: Bool) -> URL {
    return try! FileManager.default.url(for: directory, in: domain, appropriateFor: url, create: create)
  }
}

public extension URL {
  @available(*, deprecated, renamed: "tak.cachesDirectory(domain:url:create:)")
  public static func tak_cachesDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return tak.cachesDirectory(domain, url: url, create: create)
  }

  @available(*, deprecated, renamed: "tak.documentDirectory(domain:url:create:)")
  public static func tak_documentDirectory(_ domain: FileManager.SearchPathDomainMask = .userDomainMask, url: URL? = nil, create: Bool = true) -> URL {
    return tak.documentDirectory(domain, url: url, create: create)
  }
  
  @available(*, deprecated, renamed: "tak.temporaryDirectory")
  public static func tak_temporaryDirectory() -> URL {
    return tak.temporaryDirectory
  }

  @available(*, deprecated, renamed: "tak.joined(paths:)")
  public func tak_joined(_ paths: String...) -> URL {
    return paths.reduce(self, { $0.appendingPathComponent($1) })
  }

  @available(*, deprecated, renamed: "tak.URLForDirectory(directory:domain:url:create:)")
  fileprivate static func tak_URLForDirectory(_ directory: FileManager.SearchPathDirectory, domain: FileManager.SearchPathDomainMask, url: URL?, create: Bool) -> URL {
    return tak.URLForDirectory(directory, domain: domain, url: url, create: create)
  }
}
