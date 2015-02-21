//
//  UICollectionView+TAKExtensions.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation
import UIKit

public extension UICollectionView {
  public func tak_registerClassAndNibForCell(klass: UICollectionViewCell.Type) {
    tak_registerClassAndNibForCell(klass, bundle: NSBundle.mainBundle())
  }
  
  public func tak_registerClassAndNibForCell(klass: UICollectionViewCell.Type, bundle: NSBundle) {
    registerClass(klass, forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle), forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  public func tak_registerClassAndNibForHeader(klass: UICollectionReusableView.Type) {
    tak_registerClassAndNibForHeader(klass, bundle: NSBundle.mainBundle())
  }
  
  public func tak_registerClassAndNibForHeader(klass: UICollectionReusableView.Type, bundle: NSBundle) {
    registerClass(klass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
  }
}
