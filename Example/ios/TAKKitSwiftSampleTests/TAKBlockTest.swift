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
    let expectation = expectationWithDescription("run on MainThread")
    
    TAKBlock.runOnMainThread {
      XCTAssertTrue(NSThread.currentThread().isMainThread, "")
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(1.0, handler: nil)
  }
  
  func testRunInBackground() {
    let expectation = expectationWithDescription("run in Background")
    
    TAKBlock.runInBackground {
      XCTAssertFalse(NSThread.currentThread().isMainThread, "")
      expectation.fulfill()
    }
    
    waitForExpectationsWithTimeout(1.0, handler: nil)
  }
}