//
//  ControllerInstantiatable.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public protocol ControllerInstantiatable {
  associatedtype InstanceType: UIViewController = Self
  static var storyboardName: String { get }
  
  static func makeInstance() -> InstanceType?
}

public extension ControllerInstantiatable {
  static func makeInstance() -> InstanceType? {
    let identifier = InstanceType.tak_defaultIdentifier()
    
    return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? InstanceType
  }
}
