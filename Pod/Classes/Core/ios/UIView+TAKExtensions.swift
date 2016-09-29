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
  public class func tak_defaultNib(_ bundle: Bundle = Bundle.main) -> UINib {
    return UINib(nibName: tak_defaultIdentifier(), bundle: bundle)
  }
  
  public class func tak_viewFromDefaultNib(_ bundle: Bundle = Bundle.main, owner: AnyObject? = nil) -> UIView {
    let nib = tak_defaultNib(bundle)
    return nib.instantiate(withOwner: owner, options: nil)[0] as! UIView
  }
}
