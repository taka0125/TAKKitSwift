//
//  UIWindow+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

extension TAKKit where Base: UIWindow {
  public var topViewController: UIViewController? {
    return findTopViewController(base.rootViewController)
  }
}

public extension UIWindow {
  @available(*, deprecated, renamed: "tak.topViewController")
  public func tak_topViewController() -> UIViewController? {
    return tak.topViewController
  }
}

// MARK: - Private Methods

extension TAKKit where Base: UIWindow {
  fileprivate func findTopViewController(_ controller: UIViewController?) -> UIViewController? {
    guard let c = controller else { return nil }
    
    switch c {
    case let c as UITabBarController:
      return findTopViewController(c.selectedViewController)
    case let c as UINavigationController:
      return findTopViewController(c.visibleViewController)
    default:
      if let presentedViewController = c.presentedViewController {
        return findTopViewController(presentedViewController)
      }
      return c
    }
  }
}

extension UIWindow {
  @available(*, deprecated, renamed: "tak.findTopViewController(controller:)")
  fileprivate func tak_findTopViewController(_ controller: UIViewController?) -> UIViewController? {
    return tak.findTopViewController(controller)
  }
}
