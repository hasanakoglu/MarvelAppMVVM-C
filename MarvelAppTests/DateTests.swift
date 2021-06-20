//
//  DateTests.swift
//  Marvel AppTests
//
//  Created by Hasan Akoglu on 20/06/2021.
//  Copyright © 2021 hakoglu. All rights reserved.
//

import Foundation
import XCTest

@testable import Marvel_App

class DateTests: XCTestCase {
    func testDateExtension() {
        let date = Date()
        let currentDateString = date.getDateString(from: date)
        XCTAssertNotNil(currentDateString)
    }
}
