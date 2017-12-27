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
            app.navigationBars["Your deadlines"].buttons["Add"].tap()
            
            let titleTextField = app.textFields["type date title"]
            titleTextField.tap()
            titleTextField.typeText("Neues Datum")
            
            let datePickers = app.datePickers
            datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
            datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "May")
            datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "17")
        
            
            let chooseButton = app.buttons["Choose"]
            chooseButton.tap()
    }

    
    func testAddingNewDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(app.tables.staticTexts["Neues Datum"].exists)
        XCTAssertTrue(app.tables.staticTexts["May 17, 2018"].exists)
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
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2018")
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "August")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "25")
        
        let chooseButton = app.buttons["Choose"]
        chooseButton.tap()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(app.tables.staticTexts["Modified Date"].exists)
        XCTAssertTrue(app.tables.staticTexts["August 25, 2018"].exists)
    }
    
    func testDeletingArchivedDate() {
        // Use recording to get started writing UI tests.
        
        let tabBar = app.tabBars
        tabBar.buttons.element(boundBy: 1).tap()
        let tablesQuery = app.tables.cells
        let cellsCountBefore = app.cells.count
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        let cellsCountAfter = app.cells.count + 1
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
    }
    
    func testArchivingExistingDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        let tabBar = app.tabBars
        tabBar.buttons.element(boundBy: 1).tap()
        let cellsCountBeforeArchived = app.cells.count
        
        tabBar.buttons.element(boundBy: 0).tap()
        let tablesQuery = app.tables.cells
        let cellsCountBefore = app.cells.count
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Archive"].tap()
        let cellsCountAfter = app.cells.count + 1
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
        
        tabBar.buttons.element(boundBy: 1).tap()
        let cellsCountAfterArchived = app.cells.count - 1
        
        XCTAssertEqual(cellsCountBeforeArchived, cellsCountAfterArchived)
    }
    
    func testRestoringArchivedDate() {
        // Use recording to get started writing UI tests.
        
        let tabBar = app.tabBars
        tabBar.buttons.element(boundBy: 0).tap()
        let cellsCountBeforeRestored = app.cells.count
        
        tabBar.buttons.element(boundBy: 1).tap()
        let tablesQuery = app.tables.cells
        let cellsCountBefore = app.cells.count
        tablesQuery.element(boundBy: 0).swipeLeft()
        tablesQuery.element(boundBy: 0).buttons["Restore"].tap()
        let cellsCountAfter = app.cells.count + 1
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(cellsCountBefore, cellsCountAfter)
        
        tabBar.buttons.element(boundBy: 0).tap()
        let cellsCountAfterRestored = app.cells.count - 1
        
        XCTAssertEqual(cellsCountBeforeRestored, cellsCountAfterRestored)
    }
    
    func testDisplayingExistingDate() {
        // Use recording to get started writing UI tests.
        addingNewDate()
        
        app.tables.staticTexts["Modified Date"].tap()
        let dateTitleLabelElement = app.staticTexts["Modified Date in"]
        let deadlineLabelElement = app.staticTexts["7m   29d"]
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(dateTitleLabelElement.exists, true)
        XCTAssertEqual(deadlineLabelElement.exists, true)
        
    }
    
}
