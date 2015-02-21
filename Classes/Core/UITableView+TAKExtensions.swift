//
//  UITableView+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public extension UITableView {
  public func tak_registerClassAndNibForCell(klass: UITableViewCell.Type, bundle: NSBundle = NSBundle.mainBundle()) {
    registerClass(klass, forCellReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle: bundle), forCellReuseIdentifier: klass.tak_defaultIdentifier())
  }
}