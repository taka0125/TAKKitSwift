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

final class TAKUserDefaultsViewCell: UITableViewCell {
  fileprivate struct Const {
    static let Padding = CGFloat(23.0)
  }
  
  @IBOutlet fileprivate weak var keyNameLabel: UILabel!
  @IBOutlet fileprivate weak var classNameLabel: UILabel!
  @IBOutlet fileprivate weak var valueLabel: UILabel!
  
  func bind(_ key: String, value: Any?) {
    selectionStyle = .none

    guard let value = value as AnyObject? else { return }
    
    keyNameLabel?.text = key
    classNameLabel?.text = NSStringFromClass(value.classForCoder)
    valueLabel?.text = value.description
    
    let maxWidth = frame.size.width - Const.Padding
    keyNameLabel?.preferredMaxLayoutWidth = maxWidth
    classNameLabel?.preferredMaxLayoutWidth = maxWidth
    valueLabel?.preferredMaxLayoutWidth = maxWidth
  }
}
