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

extension UIColor: TAKKitCompatible {}

extension TAKKit where Base: UIColor {
  public class func hexRGBColor(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
    return hexRGBColor(red, green, blue, 100)
  }
  
  public class func hexRGBColor(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 100.0)
  }
  
  public class func rgbColor(_ c: Int) -> UIColor {
    let red = Double((c >> 16) & 0xFF) / 255.0
    let green = Double((c >> 8) & 0xFF) / 255.0
    let blue = Double(c & 0xFF) / 255.0
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
  }
  
  public class func rgbaColor(_ c: Int) -> UIColor {
    let red = Double((c >> 24) & 0xFF) / 255.0
    let green = Double((c >> 16) & 0xFF) / 255.0
    let blue = Double((c >> 8) & 0xFF) / 255.0
    let alpha = Double(c & 0xFF) / 255.0
    return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
  }
}

public extension UIColor {
  @available(*, deprecated, renamed: "tak.hexRGBColor(red:green:blue:)")
  public class func tak_HEXRGBColor(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
    return tak.hexRGBColor(red, green, blue)
  }

  @available(*, deprecated, renamed: "tak.hexRGBColor(red:green:blue:alpha:)")
  public class func tak_HEXRGBColor(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int) -> UIColor {
    return tak.hexRGBColor(red, green, blue, alpha)
  }
  
  @available(*, deprecated, renamed: "tak.rgbColor(c:)")
  public class func tak_RGBColor(_ c: Int) -> UIColor {
    return tak.rgbColor(c)
  }
  
  @available(*, deprecated, renamed: "tak.rgbaColor(c:)")
  public class func tak_RGBAColor(_ c: Int) -> UIColor {
    return tak.rgbaColor(c)
  }
}
