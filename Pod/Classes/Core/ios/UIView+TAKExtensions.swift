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
  public class func tak_defaultNib() -> UINib {
    return tak_defaultNib(nil)
  }
  
  public class func tak_defaultNib(bundle: NSBundle?) -> UINib {
    return UINib(nibName: tak_defaultIdentifier(), bundle: bundle ?? NSBundle.mainBundle())
  }
  
  public class func tak_viewFromDefaultNib() -> UIView {
    return tak_viewFromDefaultNib(NSBundle.mainBundle(), owner: nil)
  }
  
  public class func tak_viewFromDefaultNib(owner: AnyObject?) -> UIView {
    return tak_viewFromDefaultNib(NSBundle.mainBundle(), owner: owner)
  }
  
  public class func tak_viewFromDefaultNib(bundle: NSBundle, owner: AnyObject?) -> UIView {
    let nib = tak_defaultNib(bundle)
    return nib.instantiateWithOwner(owner, options: nil)[0] as! UIView
  }
}
