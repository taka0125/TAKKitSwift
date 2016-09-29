//
//  KeyboardDisplayObserver.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public final class KeyboardDisplayObserver {
  public enum EventType: String {
    case willShow, willHide
  }
  
  public typealias Callback = (_ event: EventType, _ keyboardSize: CGSize) -> ()
  
  fileprivate var callback: Callback?
  fileprivate weak var view: UIView?
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  public init() {
    let center = NotificationCenter.default
    center.tak_replaceObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow)
    center.tak_replaceObserver(self, selector: #selector(keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide)
  }
  
  public func observe(_ view: UIView? = nil, callback: @escaping Callback) {
    self.view = view
    self.callback = callback
  }
}

// MARK: - Private Methods

extension KeyboardDisplayObserver {
  @objc fileprivate func keyboardWillShow(_ notification: Notification) {
    keyboardWillChangeFrameWithNotification(notification, .willShow)
  }
  
  @objc fileprivate func keyboardWillHide(_ notification: Notification) {
    keyboardWillChangeFrameWithNotification(notification, .willHide)
  }
  
  fileprivate func keyboardWillChangeFrameWithNotification(_ notification: Notification, _ eventType: EventType) {
    let userInfo = notification.userInfo!
    let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
    
    view?.layoutIfNeeded()
    
    callback?(eventType, keyboardSize)
    
    guard let view = view else { return }
    
    view.setNeedsUpdateConstraints()
    
    let duration = TimeInterval(userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    let options = UIViewAnimationOptions(rawValue: UInt(userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber))
    
    UIView.animate(withDuration: duration, delay: 0.0, options: options,
      animations: { [weak self] () -> Void in
        if let strongSelf = self {
          strongSelf.view?.layoutIfNeeded()
        }
      },
      completion: nil
    )
  }
}

