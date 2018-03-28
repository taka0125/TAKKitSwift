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

extension TAKKit where Base == UITableView {
  
  // MARK: - register
  
  public func registerClassAndNibForCell(_ klass: UITableViewCell.Type) {
    registerClassAndNibForCell(klass, bundle: Bundle.main)
  }
  
  public func registerClassAndNibForCell(_ klass: UITableViewCell.Type, bundle: Bundle) {
    base.register(klass, forCellReuseIdentifier: klass.tak.defaultIdentifier)
    base.register(klass.tak.defaultNib(bundle), forCellReuseIdentifier: klass.tak.defaultIdentifier)
  }
  
  // MARK: - dequeue
  
  public func dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T? {
    return base.dequeueReusableCell(withIdentifier: klass.tak.defaultIdentifier) as? T
  }
  
  public func forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T {
    return dequeueReusableCell(klass)!
  }
  
  public func dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return base.dequeueReusableCell(withIdentifier: klass.tak.defaultIdentifier, for: indexPath) as? T
  }
  
  public func forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - update
  
  public func update(_ block: () -> Void) {
    base.beginUpdates()
    block()
    base.endUpdates()
  }
  
  // MARK: - reload
  
  public func reloadSections(_ sections: Set<Int>, animation: UITableViewRowAnimation) {
    update {
      var indexes = IndexSet()
      sections.forEach { section in
        indexes.insert(section)
      }
      base.reloadSections(indexes, with: animation)
    }
  }

}

public extension UITableView {
  
  // MARK: - register
  
  @available(*, deprecated, renamed: "tak.registerClassAndNibForCell(klass:)")
  public func tak_registerClassAndNibForCell(_ klass: UITableViewCell.Type) {
    tak.registerClassAndNibForCell(klass)
  }
  
  @available(*, deprecated, renamed: "tak.registerClassAndNibForCell(klass:bundle:)")
  public func tak_registerClassAndNibForCell(_ klass: UITableViewCell.Type, bundle: Bundle) {
    tak.registerClassAndNibForCell(klass, bundle: bundle)
  }
  
  // MARK: - dequeue
  
  @available(*, deprecated, renamed: "tak.dequeueReusableCell(klass:)")
  public func tak_dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T? {
    return tak.dequeueReusableCell(klass)
  }
  
  @available(*, deprecated, renamed: "tak.registerClassAndNibForCell(klass:)")
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T {
    return tak.forceDequeueReusableCell(klass)
  }

  @available(*, deprecated, renamed: "tak.dequeueReusableCell(klass:indexPath:)")
  public func tak_dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak.dequeueReusableCell(klass, indexPath: indexPath)
  }
  
  @available(*, deprecated, renamed: "tak.forceDequeueReusableCell(klass:indexPath:)")
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak.forceDequeueReusableCell(klass, indexPath: indexPath)
  }
  
  // MARK: - update
  
  @available(*, deprecated, renamed: "tak.update(block:)")
  public func tak_update(_ block: () -> Void) {
    tak.update(block)
  }
  
  // MARK: - reload
  
  @available(*, deprecated, renamed: "tak.reloadSections(sections:animation:)")
  public func tak_reloadSections(_ sections: Set<Int>, animation: UITableViewRowAnimation) {
    tak.reloadSections(sections, animation: animation)
  }
}
