//
//  CreateEventUITests.swift
//  CountToUITests
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import XCTest

class CreateEventUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()

        // Reset state
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {

    }
    
    /**
     Test creating a new event
     */
    func testCreateNewEvent() {
        app.launch()
        
        app.navigationBars["My Events"].buttons["addEventNavButton"].tap()
        app.textFields["eventNameInput"].typeText("Test123")
        app.buttons["addEventButton"].tap()
        XCTAssertTrue(app.tables.staticTexts["Test123"].exists)
    }

}
