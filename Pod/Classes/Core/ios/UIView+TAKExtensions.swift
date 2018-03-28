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

extension TAKKit where Base: UIView {
  public class func defaultNib(_ bundle: Bundle = Bundle.main) -> UINib {
    return UINib(nibName: Base.tak.defaultIdentifier, bundle: bundle)
  }
  
  public class func viewFromDefaultNib(_ bundle: Bundle = Bundle.main, owner: AnyObject? = nil) -> UIView {
    let nib = defaultNib(bundle)
    return nib.instantiate(withOwner: owner, options: nil)[0] as! UIView
  }
}

public extension UIView {
  @available(*, deprecated, renamed: "tak.defaultNib(bundle:)")
  public class func tak_defaultNib(_ bundle: Bundle = Bundle.main) -> UINib {
    return tak.defaultNib(bundle)
  }
  
  @available(*, deprecated, renamed: "tak.viewFromDefaultNib(bundle:owner:)")
  public class func tak_viewFromDefaultNib(_ bundle: Bundle = Bundle.main, owner: AnyObject? = nil) -> UIView {
    return tak.viewFromDefaultNib(bundle, owner: owner)
  }
}
