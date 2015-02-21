//
//  UIView+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public extension UIView {
  public class func tak_defaultNib(bundle: NSBundle = NSBundle.mainBundle()) -> UINib {
    return UINib(nibName: tak_defaultIdentifier(), bundle: bundle)
  }
  
  public class func tak_viewFromDefaultNib(bundle: NSBundle = NSBundle.mainBundle(), owner: AnyObject? = nil) -> UIView {
    let nib = tak_defaultNib(bundle: bundle)
    return nib.instantiateWithOwner(owner, options: nil)[0] as UIView
  }
  
  public class func tak_defaultIdentifier() -> String {
    return NSStringFromClass(self).componentsSeparatedByString(".").last!
  }
}
