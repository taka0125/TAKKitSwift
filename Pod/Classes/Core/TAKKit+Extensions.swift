//
//  TAKKit+Extensions.swift
//  Pods
//
//  Created by Tomoya Hirano on 2018/03/27.
//

import UIKit

public protocol TAKKitCompatible {
  associatedtype CompatibleType
  
  var tak: CompatibleType { get }
  static var tak: CompatibleType.Type { get }
}

public final class TAKKit<Base> {
  let base: Base
  
  public init(_ base: Base) {
    self.base = base
  }
}

public extension TAKKitCompatible {
  public var tak: TAKKit<Self> {
    return TAKKit(self)
  }
  public static var tak: TAKKit<Self>.Type { return TAKKit<Self>.self }
}
