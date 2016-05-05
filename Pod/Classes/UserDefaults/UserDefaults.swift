//
//  TAKUserDefaultsData.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

public struct UserDefaults {
  let allKeys: [String]
  
  private let items: NSDictionary

  init() {
    items = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()
    
    allKeys = items.allKeys.sort { (a, b) -> Bool in
      if let a0 = a as? String, b0 = b as? String {
        return a0 < b0
      }
      
      return false
    }.map { ($0 as? String) ?? "" }
  }
  
  subscript(key: String) -> AnyObject? {
    return items[key]
  }
  
  func filteredKeys(text: String) -> [String] {
    let predicate = NSPredicate(format: "SELF contains[c] %@", text)
    let keys = (allKeys as NSArray).filteredArrayUsingPredicate(predicate) as? [String]
    return keys ?? []
  }
}
