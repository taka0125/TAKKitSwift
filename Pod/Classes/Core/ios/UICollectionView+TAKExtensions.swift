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

  public func tak_registerClassAndNibForCell(_ klass: UICollectionViewCell.Type, bundle: Bundle = Bundle.main) {
    register(klass, forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
    register(klass.tak_defaultNib(bundle), forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  public func tak_registerClassAndNibForHeader(_ klass: UICollectionReusableView.Type, bundle: Bundle = Bundle.main) {
    register(klass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
    register(klass.tak_defaultNib(bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  // MARK: - Cell
  
  public func tak_dequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return dequeueReusableCell(withReuseIdentifier: klass.tak_defaultIdentifier(), for: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak_dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - Kind
  
  public func tak_dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T? {
    return dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: klass.tak_defaultIdentifier(), for: indexPath) as? T
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfKind(elementKind, klass: klass, indexPath: indexPath)!
  }

  // MARK: - SectionHeader
  
  public func tak_dequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionView.elementKindSectionHeader, klass: klass, indexPath: indexPath)
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfSectionHeader(klass, indexPath: indexPath)!
  }
  
  // MARK: - SectionFooter
  
  public func tak_dequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak_dequeueReusableSupplementaryViewOfKind(UICollectionView.elementKindSectionFooter, klass: klass, indexPath: indexPath)
  }
  
  public func tak_forceDequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak_dequeueReusableSupplementaryViewOfSectionFooter(klass, indexPath: indexPath)!
  }
}
