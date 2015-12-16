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
  @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
  private let observer = KeyboardDisplayObserver()
  
  override func viewDidLoad() {
    observer.observe(view, callback: { [weak self] eventType, keyboardSize in
      switch eventType {
      case .WillShow:
        self?.bottomConstraint.constant = keyboardSize.height + 8.0
      case .WillHide:
        self?.bottomConstraint.constant = 8.0
      }
    })
  }
  
  @IBAction func closeKeyboard() {
    view.endEditing(true)
  }
}