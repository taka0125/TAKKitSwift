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
  @IBOutlet private weak var imageView: UIImageView!

  private var selector: PhotoSelector?

  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
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
  
  private func launchPhotoLibrary() {
    selector?.launchPhotoLibrary(false,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .PhotoAccessDenied:
          TAKAlert.show("Photo access denied.")
        case .Cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
  
  private func launchFrontCamera() {
    selector?.launchFrontCamera(true,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .CameraIsNotAvailable, .FrontCameraIsNotAvailable:
          TAKAlert.show("Can't launch front camera.")
        case .CameraAccessDenied:
          TAKAlert.show("Camera access denied.")
        case .Cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
  
  private func launchRearCamera() {
    selector?.launchRearCamera(true,
      success: { [weak self] image in
        self?.imageView.image = image
      },
      failure: { error in
        switch error {
        case .CameraIsNotAvailable, .RearCameraIsNotAvailable:
          TAKAlert.show("Can't launch rear camera.")
        case .CameraAccessDenied:
          TAKAlert.show("Camera access denied.")
        case .Cancelled:
          TAKAlert.show("Cancelled")
        default:
          print(error)
        }
      }
    )
  }
}