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
  public typealias VoidBlock = Void -> Void
  
  // https://developer.apple.com/library/ios/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html#//apple_ref/doc/uid/TP40015243-CH39-SW1
  public enum QOS {
    case UserInteractive
    case UserInitiated
    case Default
    case Utility
    case Background
    
    public var queue: dispatch_queue_t {
      return dispatch_get_global_queue(identifier, 0)
    }
    
    private var identifier: qos_class_t {
      switch self {
      case .UserInteractive: return QOS_CLASS_USER_INTERACTIVE
      case .UserInitiated: return QOS_CLASS_USER_INITIATED
      case .Default: return QOS_CLASS_DEFAULT
      case .Utility: return QOS_CLASS_UTILITY
      case .Background: return QOS_CLASS_BACKGROUND
      }
    }
  }
  
  // MARK: - Create queue
  
  public static func createSerialQueue(name: String) -> dispatch_queue_t {
    return dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL)
  }
  
  public static func createConcurrentQueue(name: String) -> dispatch_queue_t {
    return dispatch_queue_create(name, DISPATCH_QUEUE_CONCURRENT)
  }
  
  // MARK: - MainThread
  
  public static func runOnMainThread(block: VoidBlock) {
    run(dispatch_get_main_queue(), block: block)
  }
  
  public static func runOnMainThread(delay: Double, block: VoidBlock) {
    run(dispatch_get_main_queue(), delay: delay, block: block)
  }
  
  // MARK: - Background
  
  public static func runInBackground(block: VoidBlock) {
    run(.Utility, block: block)
  }
  
  public static func runInBackground(delay: Double, block: VoidBlock) {
    run(.Utility, delay: delay, block: block)
  }
  
  // MARK: - Queue
  
  public static func run(queue: dispatch_queue_t, block: VoidBlock) {
    dispatch_async(queue, block)
  }
  
  public static func run(queue: dispatch_queue_t, delay: Double, block: VoidBlock) {
    let d = Int64(delay * Double(NSEC_PER_SEC))
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, d), queue, block)
  }
  
  // MARK: - QOS
  
  public static func run(qos: QOS, block: VoidBlock) {
    dispatch_async(qos.queue, block)
  }
  
  public static func run(qos: QOS,  delay: Double, block: VoidBlock) {
    let d = Int64(delay * Double(NSEC_PER_SEC))
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, d), qos.queue, block)
  }

  // MARK: Label

  public static func currentQueueLabel() -> String {
    return String(format: "%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL))
  }
}
