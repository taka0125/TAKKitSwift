//
//  IdentifierTest.swift
//  TAKKitSwiftSampleTests
//
//  Created by Tomoya Hirano on 2018/03/27.
//  Copyright © 2018年 Takahiro Ooishi. All rights reserved.
//

import UIKit
import XCTest
import TAKKitSwift

class IdentifierTest: XCTestCase {
  func testClass() {
    XCTAssertEqual(TAKKitClass.tak.defaultIdentifier, "TAKKitClass")
    XCTAssertEqual(TAKKitClass.tak.defaultIdentifier, TAKKitClass.tak_defaultIdentifier())
  }
}

class TAKKitClass: NSObject {}
