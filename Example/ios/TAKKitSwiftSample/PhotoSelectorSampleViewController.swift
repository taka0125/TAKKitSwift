//
//  PhotoSelectorSampleViewController.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit
import TAKKitSwift

class PhotoSelectorSampleViewController: UITableViewController {
  @IBOutlet fileprivate weak var imageView: UIImageView!

  fileprivate var selector: PhotoSelector?

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if indexPath.section != 1 { return }
    
    switch indexPath.row {
    case 0:
      launchPhotoLibrary()
    case 1:
      launchFrontCamera()
    case 2:
      launchRearCamera()
    default:
      break
    }
  }
  
  override func viewDidLoad() {
    selector = PhotoSelector()
  }
  
  fileprivate func launchPhotoLibrary() {
    selector?.launchPhotoLibrary(false,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .photoAccessDenied:
          TAKAlert.show("Photo access denied.")
        case .cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
  
  fileprivate func launchFrontCamera() {
    selector?.launchFrontCamera(true,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .cameraIsNotAvailable, .frontCameraIsNotAvailable:
          TAKAlert.show("Can't launch front camera.")
        case .cameraAccessDenied:
          TAKAlert.show("Camera access denied.")
        case .cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
  
  fileprivate func launchRearCamera() {
    selector?.launchRearCamera(true,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .cameraIsNotAvailable, .rearCameraIsNotAvailable:
          TAKAlert.show("Can't launch rear camera.")
        case .cameraAccessDenied:
          TAKAlert.show("Camera access denied.")
        case .cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
}
