//
//  KeyboardSampleViewController.swift
//  TAKKitSwiftSample
//
//  Created by Takahiro Ooishi on 2015/12/16.
//  Copyright © 2015年 Takahiro Ooishi. All rights reserved.
//

import UIKit
import TAKKitSwift

final class KeyboardSampleViewController: UIViewController {
  @IBOutlet fileprivate weak var bottomConstraint: NSLayoutConstraint!
  fileprivate let observer = KeyboardDisplayObserver()
  
  override func viewDidLoad() {
    observer.observe(view, callback: { [weak self] eventType, keyboardSize in
      switch eventType {
      case .willShow:
        self?.bottomConstraint.constant = keyboardSize.height + 8.0
      case .willHide:
        self?.bottomConstraint.constant = 8.0
      }
    })
  }
  
  @IBAction func closeKeyboard() {
    view.endEditing(true)
  }
}
