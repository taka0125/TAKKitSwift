//
//  IdentifierTest.swift
//  TAKKitSwiftSampleTests
//
//  Created by Tomoya Hirano on 2018/03/27.
//  Copyright © 2018年 Takahiro Ooishi. All rights reserved.
//

import UIKit
import XCTest
@testable import TAKKitSwift

class IdentifierTest: XCTestCase {
  func testClass() {
    XCTAssertEqual(TAKKitClass.tak_defaultIdentifier(), "TAKKitClass")
  }
}

class TAKKitClass: NSObject {}
