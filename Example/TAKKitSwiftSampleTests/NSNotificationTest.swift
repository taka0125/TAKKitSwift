//
//  NSNotificationTest.swift
//  TAKKitSwift
//
//  Created by Takahiro Ooishi
//  Copyright (c) 2015 Takahiro Ooishi. All rights reserved.
//  Released under the MIT license.
//

import UIKit
import XCTest
import TAKKitSwift

class NSNotificationTest: XCTestCase {
  private struct Const {
    static let Name = "Test"
  }
  
  func testNotificationWithName() {
    let n = NSNotification.tak_notification(Const.Name)
    
    XCTAssertEqual(Const.Name, n.name, "")
    XCTAssertNil(n.object, "")
    XCTAssertNil(n.tak_parameters, "")
  }
  
  func testNotificationWithNameAndParameters() {
    let parameters = ["key1": "value1", "key2": 2]
    let n = NSNotification.tak_notification("Test", parameters: parameters)

    XCTAssertEqual(Const.Name, n.name, "")
    XCTAssertNil(n.object, "")
    
    if let params = n.tak_parameters as? [String: NSObject] {
      XCTAssertEqual(params, parameters, "")
    } else {
      XCTFail("Mismatch Type")
    }
  }
  
  func testNotification() {
    let parameters = ["key1": "value1", "key2": 2]
    let n = NSNotification.tak_notification("Test", object: nil, parameters: parameters)
    
    XCTAssertEqual(Const.Name, n.name, "")
    XCTAssertNil(n.object, "")
    
    if let params = n.tak_parameters as? [String: NSObject] {
      XCTAssertEqual(params, parameters, "")
    } else {
      XCTFail("Mismatch Type")
    }
  }
}
