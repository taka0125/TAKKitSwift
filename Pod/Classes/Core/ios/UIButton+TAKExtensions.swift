//
//  UIButton+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2016 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import ObjectiveC

extension UIButton {
  private struct AssociatedKey {
    static var tappableInsets = UInt()
  }
  
  public var tappableInsets: UIEdgeInsets {
    get {
      let value = objc_getAssociatedObject(self, &AssociatedKey.tappableInsets) as? NSValue
      return value?.uiEdgeInsetsValue ?? UIEdgeInsets.zero
    }
    
    set {
      objc_setAssociatedObject(self, &AssociatedKey.tappableInsets, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    let insets = tappableInsets
    
    var rect = bounds
    rect.origin.x -= insets.left
    rect.origin.y -= insets.top
    rect.size.width += (insets.left + insets.right)
    rect.size.height += (insets.top + insets.bottom)
    
    return rect.contains(point)
  }
}
