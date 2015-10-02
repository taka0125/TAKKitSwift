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
  typealias InstanceType: UIViewController = Self
  static var storyboardName: String { get }
  
  static func createInstance() -> InstanceType?
}

public extension ControllerInstantiatable {
  static func createInstance() -> InstanceType? {
    let identifier = InstanceType.tak_defaultIdentifier()
    
    return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(identifier) as? InstanceType
  }
}
