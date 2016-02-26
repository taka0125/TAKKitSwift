//
//  UITableView+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public extension UITableView {
  
  // MARK: - register
  
  public func tak_registerClassAndNibForCell(klass: UITableViewCell.Type) {
    tak_registerClassAndNibForCell(klass, bundle: NSBundle.mainBundle())
  }
  
  public func tak_registerClassAndNibForCell(klass: UITableViewCell.Type, bundle: NSBundle) {
    registerClass(klass, forCellReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle), forCellReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  // MARK: - dequeue
  
  public func tak_dequeueReusableCell<T: UITableViewCell>(klass: T.Type) -> T? {
    return dequeueReusableCellWithIdentifier(klass.tak_defaultIdentifier()) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(klass: T.Type) -> T {
    return tak_dequeueReusableCell(klass)!
  }

  public func tak_dequeueReusableCell<T: UITableViewCell>(klass: T.Type, indexPath: NSIndexPath) -> T? {
    return dequeueReusableCellWithIdentifier(klass.tak_defaultIdentifier(), forIndexPath: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(klass: T.Type, indexPath: NSIndexPath) -> T {
    return tak_dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - update
  
  public func tak_update(@noescape block: Void -> Void) {
    beginUpdates()
    block()
    endUpdates()
  }
  
  // MARK: - reload
  
  public func tak_reloadSections(sections: Set<NSInteger>, animation: UITableViewRowAnimation) {
    tak_update {
      let indexes = NSMutableIndexSet()
      sections.forEach { section in
        indexes.addIndex(section)
      }
      
      reloadSections(indexes, withRowAnimation: animation)
    }
  }
}
