//
//  TAKBlock.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public struct TAKBlock {
  public typealias VoidBlock = () -> Void
  
  // https://developer.apple.com/library/ios/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html#//apple_ref/doc/uid/TP40015243-CH39-SW1
  public enum Qos {
    case userInteractive
    case userInitiated
    case `default`
    case utility
    case background
    
    public var queue: DispatchQueue {
      return DispatchQueue.global(qos: identifier)
    }
    
    fileprivate var identifier: DispatchQoS.QoSClass {
      switch self {
      case .userInteractive: return .userInteractive
      case .userInitiated: return .userInitiated
      case .default: return .default
      case .utility: return .utility
      case .background: return .background
      }
    }
  }
  
  // MARK: - Create queue
  
  public static func createSerialQueue(_ name: String) -> DispatchQueue {
    return DispatchQueue(label: name, attributes: [])
  }
  
  public static func createConcurrentQueue(_ name: String) -> DispatchQueue {
    return DispatchQueue(label: name, attributes: DispatchQueue.Attributes.concurrent)
  }
  
  // MARK: - MainThread
  
  public static func runOnMainThread(_ block: @escaping VoidBlock) {
    run(DispatchQueue.main, block: block)
  }
  
  public static func runOnMainThread(_ delay: Double, block: @escaping VoidBlock) {
    run(DispatchQueue.main, delay: delay, block: block)
  }
  
  // MARK: - Background
  
  public static func runInBackground(_ block: @escaping VoidBlock) {
    run(.utility, block: block)
  }
  
  public static func runInBackground(_ delay: Double, block: @escaping VoidBlock) {
    run(.utility, delay: delay, block: block)
  }
  
  // MARK: - Queue
  
  public static func run(_ queue: DispatchQueue, block: @escaping VoidBlock) {
    queue.async(execute: block)
  }
  
  public static func run(_ queue: DispatchQueue, delay: Double, block: @escaping VoidBlock) {
    let d = Int64(delay * Double(NSEC_PER_SEC))
    queue.asyncAfter(deadline: DispatchTime.now() + Double(d) / Double(NSEC_PER_SEC), execute: block)
  }
  
  // MARK: - QOS
  
  public static func run(_ qos: Qos, block: @escaping VoidBlock) {
    qos.queue.async(execute: block)
  }
  
  public static func run(_ qos: Qos,  delay: Double, block: @escaping VoidBlock) {
    let d = Int64(delay * Double(NSEC_PER_SEC))
    qos.queue.asyncAfter(deadline: DispatchTime.now() + Double(d) / Double(NSEC_PER_SEC), execute: block)
  }
}
