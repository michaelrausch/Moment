//
//  EditEventUITests.swift
//  EditEventUITests
//
//  Created by Michael Rausch on 13/09/19.
//  Copyright © 2019 Michael Rausch. All rights reserved.
//

import XCTest

class EditEventUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app = XCUIApplication()

        // Use argument to reset state
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
    }

    /**
     Create a new event and then delete it
     */
    func testDeleteEvent() {
        app.launch()
        
        app.navigationBars["My Events"].buttons["addEventNavButton"].tap()
        app.textFields["eventNameInput"].typeText("Test554")
        app.buttons["addEventButton"].tap()
        
        app.tables.staticTexts["Test554"].tap()
        app.buttons["removeEventButton"].doubleTap() // TODO - Why does this not pass when using a single tap?????
        
        XCTAssertEqual(app.tables.staticTexts["Test554"].exists, false)
    }
    
    /**
     Create a new event and then edit the name
     */
    func testEditEventName() {
        app.launch()
        
        app.navigationBars["My Events"].buttons["addEventNavButton"].tap()
        app.textFields["eventNameInput"].typeText("Test844")
        app.buttons["addEventButton"].tap()
        
        app.tables.staticTexts["Test844"].tap()
        
            
        let editNameField = app.textFields["eventNameEditField"]
        editNameField.tap()
        editNameField.tap()

        editNameField.typeText("999")
                
        app.buttons["saveEventButton"].doubleTap()
        
        XCTAssertTrue(app.tables.staticTexts["Test844999"].exists)
    }
}
