//
//  TAKUserDefaultsData.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

public struct UserDefaults {
  public let allKeys: [String]
  
  fileprivate let items: [String: Any]

  public init() {
    items = Foundation.UserDefaults.standard.dictionaryRepresentation()
    
    allKeys = items.keys.sorted { (a, b) -> Bool in
      if let a0 = a as? String, let b0 = b as? String {
        return a0 < b0
      }
      
      return false
    }.map { ($0 as? String) ?? "" }
  }
  
  public subscript(key: String) -> Any? {
    return items[key]
  }
  
  public func filteredKeys(_ text: String) -> [String] {
    let predicate = NSPredicate(format: "SELF contains[c] %@", text)
    let keys = (allKeys as NSArray).filtered(using: predicate) as? [String]
    return keys ?? []
  }
}
