//
//  CasesLookupRobotExt.swift
//  Covid 19 Cases LookupUITests
//
//  Created by Pavel Suvit on 02/05/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import XCTest

@testable import Covid_19_Cases_Lookup

extension CasesLookupRobot {
    func givenIHaveAnInternetConnectionAndOpenTheApp() {
        let app = XCUIApplication()
        app.launchArguments.append("CalledFromUITest")
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
    
    func andIChoseTypeOfCasesWithATitle(typeOfCases: String) {
        XCUIApplication().buttons[typeOfCases].tap()
    }
    
    func iSeeConfirmedCasesFromDataLayerForACountry(countryTitle: String) {
        if (countryTitle == "Ireland") {
            XCTAssertTrue(XCUIApplication().staticTexts["90"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["105"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iSeeDeathCasesFromDataLayerForACountry(countryTitle: String) {
        if (countryTitle == "Ireland") {
            XCTAssertTrue(XCUIApplication().staticTexts["1"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["3"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iSeeRecoveredCasesFromDataLayerForACountry(countryTitle: String) {
        if (countryTitle == "Ireland") {
            XCTAssertTrue(XCUIApplication().staticTexts["40"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["50"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeConfirmedCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "February", values: [20])
            checkMonth(monthTitle: "March", values: [45])
            checkMonth(monthTitle: "April", values: [90, 105])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeDeathCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "February", values: [3])
            checkMonth(monthTitle: "March", values: [0])
            checkMonth(monthTitle: "April", values: [1, 3])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeRecoveredCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "February", values: [105])
            checkMonth(monthTitle: "March", values: [20])
            checkMonth(monthTitle: "April", values: [40, 50])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    private func checkMonth(monthTitle: String, values: [Int]) {
        XCUIApplication().buttons[monthTitle].tap()
        values.forEach {
            XCTAssertTrue(XCUIApplication().staticTexts[String($0)].exists)
        }
    }
}
