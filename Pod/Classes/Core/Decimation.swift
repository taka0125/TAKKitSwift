//
//  Decimation.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 201６ Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public class Decimation {
  private let queue: dispatch_queue_t
  private let interval: NSTimeInterval
  private var executedAt: NSTimeInterval?
  
  public init(interval: NSTimeInterval) {
    queue = dispatch_queue_create("net.heartofsword.Throttle.\(NSUUID().UUIDString)", DISPATCH_QUEUE_SERIAL)
    self.interval = interval
  }
  
  public func execute(block: Void -> Void) {
    var decimated = false
    
    dispatch_sync(queue) {
      let now = NSDate().timeIntervalSince1970
      
      guard let executedAt = self.executedAt else {
        decimated = false
        self.executedAt = now
        
        return
      }
      
      if executedAt + self.interval > now {
        decimated = true
      } else {
        decimated = false
        self.executedAt = now
      }
    }
    
    guard !decimated else { return }
    
    block()
  }
}