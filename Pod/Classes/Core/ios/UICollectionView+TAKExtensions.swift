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

  public func tak_dequeueReusableCell<T: UICollectionViewCell>(klass: T.Type, indexPath: NSIndexPath) -> T? {
    return dequeueReusableCellWithReuseIdentifier(klass.tak_defaultIdentifier(), forIndexPath: indexPath) as? T
  }
  
  public func tak_dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(elementKind: String, klass: UICollectionReusableView.Type, indexPath: NSIndexPath) -> T? {
    return dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: klass.tak_defaultIdentifier(), forIndexPath: indexPath) as? T
  }
  
  public func tak_dequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(klass: UICollectionReusableView.Type, indexPath: NSIndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, klass: klass, indexPath: indexPath)
  }
  
  public func tak_dequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(klass: UICollectionReusableView.Type, indexPath: NSIndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, klass: klass, indexPath: indexPath)
  }
}
