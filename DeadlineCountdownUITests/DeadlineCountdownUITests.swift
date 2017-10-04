//
//  DeadlineCountdownUITests.swift
//  DeadlineCountdownUITests
//
//  Created by Nataly Tatarintseva on 7/20/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import XCTest

class DeadlineCountdownUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func addingNewDate() {
        // Use recording to get started writing UI tests.
            app.navigationBars["DeadlinesList"].buttons["Add"].tap()
            
            let titleTextField = app.textFields["type date title                    "]
            titleTextField.tap()
            titleTextField.typeText("Neues Datum")
            
            let datePickers = app.datePickers
            datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "December")
            datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "17")
            datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2017")
            
            let chooseButton = app.buttons["Choose"]
            chooseButton.tap()
    }

    
    func testAddingNewDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(app.tables.staticTexts["Neues Datum"].exists)
        XCTAssertTrue(app.tables.staticTexts["December 17, 2017"].exists)
    }
    
    func testEditingExistingDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        let tablesQuery = app.tables.cells
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Edit"].tap()
        
        let titleTextField = app.textFields.element
        titleTextField.tap()
        titleTextField.buttons["Clear text"].tap()
        titleTextField.typeText("Modified Date")
        
        let datePickers = app.datePickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "December")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "25")
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2017")
        
        let chooseButton = app.buttons["Choose"]
        chooseButton.tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(app.tables.staticTexts["Modified Date"].exists)
        XCTAssertTrue(app.tables.staticTexts["December 25, 2017"].exists)
    }
    
    func testDeletingExistingDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        let tablesQuery = app.tables.cells
        let cellsCountBefore = app.cells.count
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        let cellsCountAfter = app.cells.count + 1
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
    }
    
    func testDisplayingExistingDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        app.tables.staticTexts["Modified Date"].tap()
        let dateTitleLabelElement = app.staticTexts["Modified Date in"]
        let deadlineLabelElement = app.staticTexts["2m   21d"]
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(dateTitleLabelElement.exists, true)
        XCTAssertEqual(deadlineLabelElement.exists, true)
        
    }
    
}
