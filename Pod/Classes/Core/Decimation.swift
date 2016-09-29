//
//  Decimation.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 201６ Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import Foundation

public struct Decimation {
  fileprivate let queue: DispatchQueue = DispatchQueue(label: "net.heartofsword.Throttle.\(UUID().uuidString)", attributes: [])
  fileprivate let interval: TimeInterval
  fileprivate var executedAt: TimeInterval?
  
  public init(interval: TimeInterval) {
    self.interval = interval
  }
  
  public mutating func execute(_ block: (Void) -> Void) {
    var decimated = false
    
    queue.sync {
      let now = Date().timeIntervalSince1970
      
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
