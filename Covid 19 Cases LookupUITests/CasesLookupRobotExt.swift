//
//  CasesLookupRobotExt.swift
//  Covid 19 Cases LookupUITests
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import XCTest

let TEST_ARGUMENT = "CalledFromUITest"


extension CasesLookupRobot {
    func givenIHaveAnInternetConnectionAndOpenTheApp() {
        let app = XCUIApplication()
        app.launchArguments.append(TEST_ARGUMENT)
        app.launch()
    }
    
    func iSeeAScreenWithAvailableCountries() {
        XCTAssertTrue(XCUIApplication().staticTexts["Ireland"].exists)
        XCTAssertTrue(XCUIApplication().staticTexts["Russia"].exists)
        XCTAssertTrue(XCUIApplication().staticTexts["UK"].exists)
    }
}
