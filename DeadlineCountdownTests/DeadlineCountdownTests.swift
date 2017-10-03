//
//  DeadlineCountdownTests.swift
//  DeadlineCountdownTests
//
//  Created by Nataly Tatarintseva on 7/20/17.
//  Copyright © 2017 Nataly Tatarintseva. All rights reserved.
//

import XCTest
@testable import DeadlineCountdown

class DeadlineCountdownTests: XCTestCase {
    
    var textUnderTest: DeadlineText!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        textUnderTest = nil
        super.tearDown()
    }
    
    func testTodayIsDeadline() {
        
        textUnderTest = DeadlineText(years: 0, months: 0, days: 0)
        XCTAssertEqual(textUnderTest.toString(), "Today is Deadline")

    }
    
    func testDisplayingAllParts() {
        
        textUnderTest = DeadlineText(years: 3, months: 5, days: 9)
        XCTAssertEqual(textUnderTest.toString(), "3y   5m   9d")
    }
    
    func testDisplayingYearsAndDays() {
        
        textUnderTest = DeadlineText(years: 5, months: 0, days: 15)
        XCTAssertEqual(textUnderTest.toString(), "5y   15d")
    }

    func testDisplayingMonthsAndDays() {
        
        textUnderTest = DeadlineText(years: 0, months: 7, days: 3)
        XCTAssertEqual(textUnderTest.toString(), "7m   3d")
    }
    
    func testDisplayingYears() {
        
        textUnderTest = DeadlineText(years: 25, months: 0, days: 0)
        XCTAssertEqual(textUnderTest.toString(), "25y")
    }
    
    func testDisplayingDays() {
        
        textUnderTest = DeadlineText(years: 0, months: 0, days: 10)
        XCTAssertEqual(textUnderTest.toString(), "10d")
    }
    
}

