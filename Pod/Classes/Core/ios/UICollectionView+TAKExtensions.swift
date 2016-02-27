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
  
  // MARK: - register

  public func tak_registerClassAndNibForCell(klass: UICollectionViewCell.Type, bundle: NSBundle = NSBundle.mainBundle()) {
    registerClass(klass, forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle), forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  public func tak_registerClassAndNibForHeader(klass: UICollectionReusableView.Type, bundle: NSBundle = NSBundle.mainBundle()) {
    registerClass(klass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
    registerNib(klass.tak_defaultNib(bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  // MARK: - Cell
  
  public func tak_dequeueReusableCell<T: UICollectionViewCell>(klass: T.Type, indexPath: NSIndexPath) -> T? {
    return dequeueReusableCellWithReuseIdentifier(klass.tak_defaultIdentifier(), forIndexPath: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UICollectionViewCell>(klass: T.Type, indexPath: NSIndexPath) -> T {
    return tak_dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - Kind
  
  public func tak_dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(elementKind: String, klass: T.Type, indexPath: NSIndexPath) -> T? {
    return dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: klass.tak_defaultIdentifier(), forIndexPath: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(elementKind: String, klass: T.Type, indexPath: NSIndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfKind(elementKind, klass: klass, indexPath: indexPath)!
  }

  // MARK: - SectionHeader
  
  public func tak_dequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(klass: T.Type, indexPath: NSIndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, klass: klass, indexPath: indexPath)
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(klass: T.Type, indexPath: NSIndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfSectionHeader(klass, indexPath: indexPath)!
  }
  
  // MARK: - SectionFooter
  
  public func tak_dequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(klass: T.Type, indexPath: NSIndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, klass: klass, indexPath: indexPath)
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(klass: T.Type, indexPath: NSIndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfSectionFooter(klass, indexPath: indexPath)!
  }
}
