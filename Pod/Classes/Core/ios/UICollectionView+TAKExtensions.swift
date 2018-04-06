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

extension TAKKit where Base == UICollectionView {
  
  // MARK: - register
  
  public func registerClassAndNibForCell<T: UICollectionViewCell>(_ klass: T.Type, bundle: Bundle = Bundle.main) {
    base.register(klass, forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
    base.register(klass.tak.defaultNib(bundle), forCellWithReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  public func registerClassAndNibForHeader<T: UICollectionViewCell>(_ klass: T.Type, bundle: Bundle = Bundle.main) {
    base.register(klass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
    base.register(klass.tak.defaultNib(bundle), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: klass.tak_defaultIdentifier())
  }
  
  // MARK: - Cell
  
  public func dequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return base.dequeueReusableCell(withReuseIdentifier: klass.tak_defaultIdentifier(), for: indexPath) as? T
  }
  
  public func forceDequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableCell(klass, indexPath: indexPath)!
  }
  
  // MARK: - Kind
  
  public func dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T? {
    return base.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: klass.tak_defaultIdentifier(), for: indexPath) as? T
  }
  
  public func forceDequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableSupplementaryViewOfKind(elementKind, klass: klass, indexPath: indexPath)!
  }
  
  // MARK: - SectionHeader
  
  public func dequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, klass: klass, indexPath: indexPath)
  }
  
  public func forceDequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableSupplementaryViewOfSectionHeader(klass, indexPath: indexPath)!
  }
  
  // MARK: - SectionFooter
  
  public func dequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, klass: klass, indexPath: indexPath)
  }
  
  public func forceDequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return dequeueReusableSupplementaryViewOfSectionFooter(klass, indexPath: indexPath)!
  }
}



public extension UICollectionView {
  
  // MARK: - register

  @available(*, deprecated, renamed: "tak.registerClassAndNibForCell(klass:bundle:)")
  public func tak_registerClassAndNibForCell<T: UICollectionViewCell>(_ klass: T.Type, bundle: Bundle = Bundle.main) {
    tak.registerClassAndNibForCell(klass, bundle: bundle)
  }
  
  @available(*, deprecated, renamed: "tak.registerClassAndNibForHeader(klass:bundle:)")
  public func tak_registerClassAndNibForHeader<T: UICollectionViewCell>(_ klass: T.Type, bundle: Bundle = Bundle.main) {
    tak.registerClassAndNibForHeader(klass, bundle: bundle)
  }
  
  // MARK: - Cell
  
  @available(*, deprecated, renamed: "tak.dequeueReusableCell(klass:indexPath:)")
  public func tak_dequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak.dequeueReusableCell(klass, indexPath: indexPath)
  }
  
  @available(*, deprecated, renamed: "tak.forceDequeueReusableCell(klass:indexPath:)")
  public func tak_forceDequeueReusableCell<T: UICollectionViewCell>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak.forceDequeueReusableCell(klass, indexPath: indexPath)
  }
  
  // MARK: - Kind
  
  @available(*, deprecated, renamed: "tak.dequeueReusableSupplementaryViewOfKind(elementKind:klass:indexPath:)")
  public func tak_dequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T? {
    return tak.dequeueReusableSupplementaryViewOfKind(elementKind, klass: klass, indexPath: indexPath)
  }
  
  @available(*, deprecated, renamed: "tak.forceDequeueReusableSupplementaryViewOfKind(elementKind:klass:indexPath:)")
  public func tak_forceDequeueReusableSupplementaryViewOfKind<T: UICollectionReusableView>(_ elementKind: String, klass: T.Type, indexPath: IndexPath) -> T {
    return tak.forceDequeueReusableSupplementaryViewOfKind(elementKind, klass: klass, indexPath: indexPath)
  }

  // MARK: - SectionHeader
  
  @available(*, deprecated, renamed: "tak.dequeueReusableSupplementaryViewOfSectionHeader(klass:indexPath:)")
  public func tak_dequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak.dequeueReusableSupplementaryViewOfSectionHeader(klass, indexPath: indexPath)
  }
  
  @available(*, deprecated, renamed: "tak.forceDequeueReusableSupplementaryViewOfSectionHeader(klass:indexPath:)")
  public func tak_forceDequeueReusableSupplementaryViewOfSectionHeader<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak.forceDequeueReusableSupplementaryViewOfSectionHeader(klass, indexPath: indexPath)
  }
  
  // MARK: - SectionFooter
  
  @available(*, deprecated, renamed: "tak.dequeueReusableSupplementaryViewOfSectionFooter(klass:indexPath:)")
  public func tak_dequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T? {
    return tak.dequeueReusableSupplementaryViewOfSectionFooter(klass, indexPath: indexPath)
  }
  
  @available(*, deprecated, renamed: "tak.forceDequeueReusableSupplementaryViewOfSectionFooter(klass:indexPath:)")
  public func tak_forceDequeueReusableSupplementaryViewOfSectionFooter<T: UICollectionReusableView>(_ klass: T.Type, indexPath: IndexPath) -> T {
    return tak.forceDequeueReusableSupplementaryViewOfSectionFooter(klass, indexPath: indexPath)
  }
}
