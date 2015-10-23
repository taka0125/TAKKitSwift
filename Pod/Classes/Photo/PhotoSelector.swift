//
//  PhotoSelector.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import Photos
import AVFoundation

final public class PhotoSelector: NSObject {
  public enum Error: ErrorType {
    case CameraAccessDenied
    case PhotoAccessDenied
    case CameraIsNotAvailable
    case FrontCameraIsNotAvailable
    case RearCameraIsNotAvailable
    case PhotoLibraryIsNotAvailable
    case Cancelled
  }
  
  public typealias SuccessCallback = (UIImage?) -> Void
  public typealias FailureCallback = (Error) -> Void
  
  private var success: SuccessCallback?
  private var failure: FailureCallback?
  
  public func launchPhotoLibrary(allowsEditing: Bool, success: SuccessCallback, failure: FailureCallback? = nil) {
    self.success = success
    self.failure = failure
    
    guard UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) else {
      failure?(Error.PhotoLibraryIsNotAvailable)
      return
    }
    
    verifyAccessPhotoPermission { [weak self] in
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = .PhotoLibrary
      picker.allowsEditing = allowsEditing
      
      if let w = UIApplication.sharedApplication().delegate?.window, window = w, top = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          top.presentViewController(picker, animated: true, completion: nil)
        }
      }
    }
  }
  
  public func launchFrontCamera(allowsEditing: Bool, success: SuccessCallback, failure: FailureCallback? = nil) {
    launchCamera(.Front, allowsEditing: allowsEditing, success: success, failure: failure)
  }
  
  public func launchRearCamera(allowsEditing: Bool, success: SuccessCallback, failure: FailureCallback? = nil) {
    launchCamera(.Rear, allowsEditing: allowsEditing, success: success, failure: failure)
  }
}

// MARK: - Photo

private extension PhotoSelector {
  private func verifyAccessPhotoPermission(success: Void -> Void) {
    switch PHPhotoLibrary.authorizationStatus() {
    case .Authorized:
      success()
    case .Restricted, .Denied:
      failure?(Error.PhotoAccessDenied)
    case .NotDetermined:
      requestAccessForPhoto(success)
    }
  }
  
  
  private func requestAccessForPhoto(success: Void -> Void) {
    TAKBlock.runOnMainThread {
      PHPhotoLibrary.requestAuthorization { [weak self] (status) -> Void in
        guard status == .Authorized else {
          self?.failure?(Error.PhotoAccessDenied)
          
          return
        }
        
        success()
      }
    }
  }
}

// MARK: - Camera

private extension PhotoSelector {
  private func launchCamera(cameraDevice: UIImagePickerControllerCameraDevice, allowsEditing: Bool, success: SuccessCallback, failure: FailureCallback? = nil) {
    self.success = success
    self.failure = failure
    
    guard UIImagePickerController.isSourceTypeAvailable(.Camera) else {
      failure?(Error.CameraIsNotAvailable)
      return
    }
    
    guard UIImagePickerController.isCameraDeviceAvailable(cameraDevice) else {
      switch cameraDevice {
      case .Front:
        failure?(Error.FrontCameraIsNotAvailable)
      case .Rear:
        failure?(Error.RearCameraIsNotAvailable)
      }
      
      return
    }
    
    verifyAccessCameraPermission { [weak self] in
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = .Camera
      picker.cameraDevice = cameraDevice
      picker.allowsEditing = allowsEditing
      
      if let w = UIApplication.sharedApplication().delegate?.window, window = w, top = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          top.presentViewController(picker, animated: true, completion: nil)
        }
      }
    }
  }
  
  private func verifyAccessCameraPermission(success: Void -> Void) {
    let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
    switch status {
    case .Authorized:
      success()
    case .Restricted, .Denied:
      failure?(Error.CameraAccessDenied)
    case .NotDetermined:
      requestAccessForCamera(success)
    }
  }
  
  private func requestAccessForCamera(success: Void -> Void) {
    TAKBlock.runOnMainThread {
      AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo,
        completionHandler: { [weak self] (granted) in
          guard granted else {
            self?.failure?(Error.CameraAccessDenied)
            return
          }
          
          success()
        }
      )
    }
  }
}

// MARK: - UIImagePickerControllerDelegate

// privateにできない…
extension PhotoSelector: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    if let w = UIApplication.sharedApplication().delegate?.window, window = w, top = window.tak_topViewController() {
      top.dismissViewControllerAnimated(true, completion: { [weak self] in
        self?.success?(info[UIImagePickerControllerOriginalImage] as? UIImage)
        })
      
      return
    }
    
    success?(info[UIImagePickerControllerOriginalImage] as? UIImage)
  }
  
  public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    if let w = UIApplication.sharedApplication().delegate?.window, window = w, top = window.tak_topViewController() {
      top.dismissViewControllerAnimated(true, completion: { [weak self] in
        self?.failure?(Error.Cancelled)
        })
      
      return
    }
    
    failure?(Error.Cancelled)
  }
}
