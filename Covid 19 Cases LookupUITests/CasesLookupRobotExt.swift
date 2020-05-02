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
        print("Not implemented")
        XCTAssertTrue(false)
    }
}
