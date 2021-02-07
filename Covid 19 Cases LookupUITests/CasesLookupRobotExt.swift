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
            XCTAssertTrue(XCUIApplication().staticTexts["45"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["15"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iSeeDeathCasesFromDataLayerForACountry(countryTitle: String) {
        if (countryTitle == "Ireland") {
            XCTAssertTrue(XCUIApplication().staticTexts["1"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["2"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iSeeRecoveredCasesFromDataLayerForACountry(countryTitle: String) {
        if (countryTitle == "Ireland") {
            XCTAssertTrue(XCUIApplication().staticTexts["20"].exists)
            XCTAssertTrue(XCUIApplication().staticTexts["10"].exists)
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeConfirmedCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "Feb", values: [20])
            checkMonth(monthTitle: "Mar", values: [25])
            checkMonth(monthTitle: "Apr", values: [45, 15])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeDeathCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "Feb", values: [3])
            checkMonth(monthTitle: "Mar", values: [0])
            checkMonth(monthTitle: "Apr", values: [1, 2])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    func iCanSeeRecoveredCasesForAllAvailableMonths(countryTitle: String) {
        if (countryTitle == "Ireland") {
            checkMonth(monthTitle: "Feb", values: [105])
            checkMonth(monthTitle: "Mar", values: [0])
            checkMonth(monthTitle: "Apr", values: [20, 10])
        } else {
            XCTAssertTrue(false, "There is only stats for Ireland in a local repo")
        }
    }
    
    private func checkMonth(monthTitle: String, values: [Int]) {
        XCUIApplication().pickerWheels.element.adjust(toPickerWheelValue: monthTitle)
        values.forEach {
            XCTAssertTrue(XCUIApplication().staticTexts[String($0)].exists)
        }
    }
}
