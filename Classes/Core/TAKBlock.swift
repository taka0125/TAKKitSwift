//
//  TAKBlock.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public class TAKBlock {
  public typealias VoidBlock = Void -> Void
  
  // MARK: - MainThread
  
  public class func runOnMainThread(block: VoidBlock) {
    run(dispatch_get_main_queue(), block: block)
  }
  
  public class func runOnMainThread(block: VoidBlock, delay: Double) {
    run(dispatch_get_main_queue(), block: block, delay: delay)
  }
  
  // MARK: - Background
  
  public class func runInBackground(block: VoidBlock) {
    run(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block: block)
  }
  
  public class func runInBackground(block: VoidBlock, delay: Double) {
    run(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block: block, delay: delay)
  }
  
  // MARK: - Queue
  
  public class func run(queue: dispatch_queue_t, block: VoidBlock) {
    dispatch_async(queue, block)
  }
  
  public class func run(queue: dispatch_queue_t, block: VoidBlock, delay: Double) {
    let d = Int64(delay * Double(NSEC_PER_SEC))
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, d), queue, block)
  }
}