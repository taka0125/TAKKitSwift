//
//  TAKBlockTest.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import XCTest
import TAKKitSwift

class TAKBlockTest: XCTestCase {
  func testRunOnMainThread() {
    let expectation = self.expectation(description: "run on MainThread")
    
    TAKBlock.runOnMainThread {
      XCTAssertTrue(Thread.current.isMainThread, "")
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func testRunInBackground() {
    let expectation = self.expectation(description: "run in Background")
    
    TAKBlock.runInBackground {
      XCTAssertFalse(Thread.current.isMainThread, "")
      expectation.fulfill()
    }
    
    waitForExpectations(timeout: 1.0, handler: nil)
  }
}
