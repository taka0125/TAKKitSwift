//
//  TAKUserDefaultsData.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

final class TAKUserDefaultsData {
  static let sharedInstance = TAKUserDefaultsData()
  private(set) var items: NSDictionary
  private(set) var allKeys: [String]
  
  private init() {
    items = [:]
    allKeys = []
  }
  
  func load() {
    items = NSUserDefaults.standardUserDefaults().dictionaryRepresentation()
    
    allKeys = items.allKeys.sort {
      (a, b) -> Bool in
      
      if let a0 = a as? String, b0 = b as? String {
        return a0 < b0
      }
      
      return false
    }.map({ ($0 as? String) ?? "" })
  }
  
  func item(key: String) -> AnyObject? {
    return items[key]
  }
  
  func filteredKeys(text: String) -> [String] {
    let predicate = NSPredicate(format: "SELF contains[c] %@", text)
    let keys = (allKeys as NSArray).filteredArrayUsingPredicate(predicate) as? [String]
    return keys ?? []
  }
}