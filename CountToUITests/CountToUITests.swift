//
//  CountToUITests.swift
//  CountToUITests
//
//  Created by Michael Rausch on 12/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import XCTest

class CountToUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {
    }

    /**
     Measure how long it takes to launch app
     */
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
