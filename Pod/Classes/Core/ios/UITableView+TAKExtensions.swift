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
  
  public func tak_registerClassAndNibForCell(_ klass: UITableViewCell.Type) {
    tak_registerClassAndNibForCell(klass, bundle: Bundle.main)
  }
  
  public func tak_registerClassAndNibForCell(_ klass: UITableViewCell.Type, bundle: Bundle) {
    register(klass, forCellReuseIdentifier: klass.tak_defaultIdentifier())
    register(klass.tak_defaultNib(bundle), forCellReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  // MARK: - dequeue
  
  public func tak_dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T? {
    return dequeueReusableCell(withIdentifier: klass.tak_defaultIdentifier()) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type) -> T {
    return tak_dequeueReusableCell(klass)!
  }

  public func tak_dequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return dequeueReusableCell(withIdentifier: klass.tak_defaultIdentifier(), for: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UITableViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak_dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - update
  
  public func tak_update(_ block: () -> Void) {
    beginUpdates()
    block()
    endUpdates()
  }
  
  // MARK: - reload
  
  public func tak_reloadSections(_ sections: Set<Int>, animation: UITableView.RowAnimation) {
    tak_update {
      var indexes = IndexSet()
      sections.forEach { section in
        indexes.insert(section)
      }
      reloadSections(indexes, with: animation)
    }
  }
}
