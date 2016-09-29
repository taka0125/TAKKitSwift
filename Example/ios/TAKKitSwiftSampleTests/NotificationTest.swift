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

class NotificationTest: XCTestCase {
  fileprivate struct Const {
    static let Name = "Test"
  }
  
  func testNotificationWithName() {
    let n = Notification.tak_notification(Const.Name)
    
    XCTAssertEqual(Const.Name, n.name.rawValue, "")
    XCTAssertNil(n.object, "")
    XCTAssertNil(n.tak_parameters, "")
  }
  
  func testNotificationWithNameAndParameters() {
    let parameters: [String: String] = ["key1": "value1", "key2": "2"]
    let n = Notification.tak_notification("Test", parameters: parameters)

    XCTAssertEqual(Const.Name, n.name.rawValue, "")
    XCTAssertNil(n.object, "")
    
    if let params = n.tak_parameters as? [String: String] {
      XCTAssertEqual(params, parameters, "")
    } else {
      XCTFail("Mismatch Type")
    }
  }
  
  func testNotification() {
    let parameters: [String : String] = ["key1": "value1", "key2": "2"]
    let n = Notification.tak_notification("Test", object: nil, parameters: parameters)
    
    XCTAssertEqual(Const.Name, n.name.rawValue, "")
    XCTAssertNil(n.object, "")
    
    if let params = n.tak_parameters as? [String: String] {
      XCTAssertEqual(params, parameters, "")
    } else {
      XCTFail("Mismatch Type")
    }
  }
}
