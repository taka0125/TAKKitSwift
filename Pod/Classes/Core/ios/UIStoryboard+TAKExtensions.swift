//
//  UIStoryboard+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

extension TAKKit where Base == UIStoryboard {
  public func instantiateViewController<T: UIViewController>(_ klass: T.Type) -> T? {
    return base.instantiateViewController(withIdentifier: T.tak_defaultIdentifier()) as? T
  }
}

public extension UIStoryboard {
  @available(*, deprecated, renamed: "tak.instantiateViewController(klass:)")
  public func tak_instantiateViewController<T: UIViewController>(_ klass: T.Type) -> T? {
    return tak.instantiateViewController(klass)
  }
}
