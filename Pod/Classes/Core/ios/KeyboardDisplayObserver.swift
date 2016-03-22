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
    case WillShow, WillHide
  }
  
  public typealias Callback = (event: EventType, keyboardSize: CGSize) -> ()
  
  private var callback: Callback?
  private weak var view: UIView?
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  public init() {
    let center = NSNotificationCenter.defaultCenter()
    center.tak_replaceObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification)
    center.tak_replaceObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification)
  }
  
  public func observe(view: UIView? = nil, callback: Callback) {
    self.view = view
    self.callback = callback
  }
  
  // MARK: - Private Methods
  
  @objc private func keyboardWillShow(notification: NSNotification) {
    keyboardWillChangeFrameWithNotification(notification, .WillShow)
  }
  
  @objc private func keyboardWillHide(notification: NSNotification) {
    keyboardWillChangeFrameWithNotification(notification, .WillHide)
  }
  
  private func keyboardWillChangeFrameWithNotification(notification: NSNotification, _ eventType: EventType) {
    let userInfo = notification.userInfo!
    let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
    
    view?.layoutIfNeeded()
    
    callback?(event: eventType, keyboardSize: keyboardSize)
    
    guard let view = view else { return }
    
    view.setNeedsUpdateConstraints()
    
    let duration = NSTimeInterval(userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber)
    let options = UIViewAnimationOptions(rawValue: UInt(userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber))
    
    UIView.animateWithDuration(duration, delay: 0.0, options: options,
      animations: { [weak self] () -> Void in
        if let strongSelf = self {
          strongSelf.view?.layoutIfNeeded()
        }
      },
      completion: nil
    )
  }
}

