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
    
    func iSeeAScreenOfAvailableCountries() {
        XCTAssertTrue(XCUIApplication().buttons["Ireland"].exists)
        XCTAssertTrue(XCUIApplication().buttons["Russia"].exists)
        XCTAssertTrue(XCUIApplication().buttons["UK"].exists)
    }
    
    func andIClickOnACountryWithATitle(countryTitle: String) {
        XCUIApplication().buttons[countryTitle].tap()
    }
    
    func iSeeStatsScreenForACountry(countryTitle: String) {
        XCTAssertTrue(XCUIApplication().staticTexts["Cases in " + countryTitle].exists)
    }
    
    func iSeeStatsFromDataLayerForACountry(countryTitle: String) {
        XCTAssertTrue(XCUIApplication().staticTexts["There are 105 confirmed cases as of 2020-04-05T00:00:00Z"].exists)
    }
}
