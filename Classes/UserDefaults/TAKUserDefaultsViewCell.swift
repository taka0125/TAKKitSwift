//
//  TAKUserDefaultsViewCell.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public class TAKUserDefaultsViewCell: UITableViewCell {
  private struct Const {
    static let Padding = CGFloat(23.0)
  }
  
  @IBOutlet private weak var keyNameLabel: UILabel!
  @IBOutlet private weak var classNameLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!
  
  func bind(key: String, value: AnyObject) {
    selectionStyle = .None
    
    keyNameLabel?.text = key
    classNameLabel?.text = NSStringFromClass(value.classForCoder)
    valueLabel?.text = value.description
    
    let maxWidth = frame.size.width - Const.Padding
    keyNameLabel?.preferredMaxLayoutWidth = maxWidth
    classNameLabel?.preferredMaxLayoutWidth = maxWidth
    valueLabel?.preferredMaxLayoutWidth = maxWidth
  }
}