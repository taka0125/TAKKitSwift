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
    guard let userInfo = notification.userInfo else { return }
    guard let duration: TimeInterval = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
    guard let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int else { return }

    let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
    
    view?.layoutIfNeeded()
    
    callback?(eventType, keyboardSize)
    
    guard let view = view else { return }
    
    view.setNeedsUpdateConstraints()
    
    let options = UIViewAnimationOptions(rawValue: UInt(animationCurve))
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

