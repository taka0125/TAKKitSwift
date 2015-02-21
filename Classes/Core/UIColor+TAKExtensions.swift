//
//  UIColor+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public extension UIColor {
  public class func tak_HEXRGBColor(red: Int, _ green: Int, _ blue: Int, _ alpha: Int = 100) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 100.0)
  }
  
  public class func tak_RGBColor(c: Int) -> UIColor {
    let red = Double((c >> 16) & 0xFF) / 255.0
    let green = Double((c >> 8) & 0xFF) / 255.0
    let blue = Double(c & 0xFF) / 255.0
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
  }
  
  public class func tak_RGBAColor(c: Int) -> UIColor {
    let red = Double((c >> 24) & 0xFF) / 255.0
    let green = Double((c >> 16) & 0xFF) / 255.0
    let blue = Double((c >> 8) & 0xFF) / 255.0
    let alpha = Double(c & 0xFF) / 255.0
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
  }
}
