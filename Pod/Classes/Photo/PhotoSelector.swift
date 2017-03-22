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

public final class PhotoSelector: NSObject {
  public enum CustomError: Error {
    case cameraAccessDenied
    case photoAccessDenied
    case cameraIsNotAvailable
    case frontCameraIsNotAvailable
    case rearCameraIsNotAvailable
    case photoLibraryIsNotAvailable
    case cancelled
  }
  
  public typealias SuccessCallback = (UIImage?) -> Void
  public typealias FailureCallback = (CustomError) -> Void
  
  fileprivate var allowsEditing: Bool = false
  fileprivate var success: SuccessCallback?
  fileprivate var failure: FailureCallback?
  
  public func launchPhotoLibrary(_ allowsEditing: Bool, success: @escaping SuccessCallback, failure: @escaping FailureCallback = { _ in }) {
    self.allowsEditing = allowsEditing
    self.success = success
    self.failure = failure
    
    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
      failure(CustomError.photoLibraryIsNotAvailable)
      return
    }
    
    verifyAccessPhotoPermission { [weak self] in
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = .photoLibrary
      picker.allowsEditing = allowsEditing
      
      if let w = UIApplication.shared.delegate?.window, let window = w, let top = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          top.present(picker, animated: true, completion: nil)
        }
      }
    }
  }
  
  public func launchFrontCamera(_ allowsEditing: Bool, success: @escaping SuccessCallback, failure: @escaping FailureCallback = { _ in }) {
    launchCamera(.front, allowsEditing: allowsEditing, success: success, failure: failure)
  }
  
  public func launchRearCamera(_ allowsEditing: Bool, success: @escaping SuccessCallback, failure: @escaping FailureCallback = { _ in }) {
    launchCamera(.rear, allowsEditing: allowsEditing, success: success, failure: failure)
  }
}

// MARK: - Photo

extension PhotoSelector {
  fileprivate func verifyAccessPhotoPermission(_ success: @escaping (Void) -> Void) {
    switch PHPhotoLibrary.authorizationStatus() {
    case .authorized:
      success()
    case .restricted, .denied:
      failure?(CustomError.photoAccessDenied)
    case .notDetermined:
      requestAccessForPhoto(success)
    }
  }
  
  fileprivate func requestAccessForPhoto(_ success: @escaping (Void) -> Void) {
    TAKBlock.runOnMainThread {
      PHPhotoLibrary.requestAuthorization { [weak self] (status) -> Void in
        guard status == .authorized else {
          self?.failure?(CustomError.photoAccessDenied)
          
          return
        }
        
        success()
      }
    }
  }
}

// MARK: - Camera

extension PhotoSelector {
  fileprivate func launchCamera(_ cameraDevice: UIImagePickerControllerCameraDevice, allowsEditing: Bool, success: @escaping SuccessCallback, failure: @escaping FailureCallback = {_ in }) {
    self.allowsEditing = allowsEditing
    self.success = success
    self.failure = failure
    
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
      failure(CustomError.cameraIsNotAvailable)
      return
    }
    
    guard UIImagePickerController.isCameraDeviceAvailable(cameraDevice) else {
      switch cameraDevice {
      case .front:
        failure(CustomError.frontCameraIsNotAvailable)
      case .rear:
        failure(CustomError.rearCameraIsNotAvailable)
      }
      
      return
    }
    
    verifyAccessCameraPermission { [weak self] in
      let picker = UIImagePickerController()
      picker.delegate = self
      picker.sourceType = .camera
      picker.cameraDevice = cameraDevice
      picker.allowsEditing = allowsEditing
      
      if let w = UIApplication.shared.delegate?.window, let window = w, let top = window.tak_topViewController() {
        TAKBlock.runOnMainThread {
          top.present(picker, animated: true, completion: nil)
        }
      }
    }
  }
  
  fileprivate func verifyAccessCameraPermission(_ success: @escaping (Void) -> Void) {
    let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    switch status {
    case .authorized:
      success()
    case .restricted, .denied:
      failure?(CustomError.cameraAccessDenied)
    case .notDetermined:
      requestAccessForCamera(success)
    }
  }
  
  fileprivate func requestAccessForCamera(_ success: @escaping (Void) -> Void) {
    TAKBlock.runOnMainThread {
      AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo,
        completionHandler: { [weak self] (granted) in
          guard granted else {
            self?.failure?(CustomError.cameraAccessDenied)
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
  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let key = allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage
    let image = info[key] as? UIImage
    
    if let w = UIApplication.shared.delegate?.window, let window = w, let top = window.tak_topViewController() {
      top.dismiss(animated: true, completion: { [weak self] in
        self?.success?(image)
      })
      
      return
    }
    
    success?(image)
  }
  
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    if let w = UIApplication.shared.delegate?.window, let window = w, let top = window.tak_topViewController() {
      top.dismiss(animated: true, completion: { [weak self] in
        self?.failure?(CustomError.cancelled)
        })
      
      return
    }
    
    failure?(CustomError.cancelled)
  }
}
