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

public extension UIWindow {
  public func tak_topViewController() -> UIViewController? {
    return tak_findTopViewController(rootViewController)
  }
}

// MARK: - Private Methods

extension UIWindow {
  fileprivate func tak_findTopViewController(_ controller: UIViewController?) -> UIViewController? {
    guard let c = controller else { return nil }
    
    switch c {
    case let c as UITabBarController:
      return tak_findTopViewController(c.selectedViewController)
    case let c as UINavigationController:
      return tak_findTopViewController(c.visibleViewController)
    default:
      if let presentedViewController = c.presentedViewController {
        return tak_findTopViewController(presentedViewController)
      }
      return c
    }
  }
}
