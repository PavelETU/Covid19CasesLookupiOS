//
//  Covid_19_Cases_LookupUITests.swift
//  Covid 19 Cases LookupUITests
//
//  Created by Pavel Suvit on 27/04/2020.
//  Copyright © 2020 Pavel Suvit. All rights reserved.
//

import XCTest

class Covid_19_Cases_LookupUITests: XCTestCase, CasesLookupRobot {
    func testCountriesListIsDisplayedWhenAppIsOpened() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        iSeeAScreenOfAvailableCountries()
    }
    
    func testScreenWithStatsIsPresentedAftreClickingOnACountry() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        iSeeAScreenOfAvailableCountries()
        andIClickOnACountryWithATitle(countryTitle: "Russia")
        iSeeStatsScreenForACountry(countryTitle: "Russia")
    }
    
    func testRightConfirmedStatsAreDisplayed() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        andIClickOnACountryWithATitle(countryTitle: "Ireland")
        iSeeConfirmedCasesFromDataLayerForACountry(countryTitle: "Ireland")
    }
    
    func testRightDeathCasesAreDisplayed() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        andIClickOnACountryWithATitle(countryTitle: "Ireland")
        andIChoseTypeOfCasesWithATitle(typeOfCases: "Deaths")
        iSeeDeathCasesFromDataLayerForACountry(countryTitle: "Ireland")
    }
    
    func testRightRecoveredCasesAreDisplayed() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        andIClickOnACountryWithATitle(countryTitle: "Ireland")
        andIChoseTypeOfCasesWithATitle(typeOfCases: "Recovered")
        iSeeRecoveredCasesFromDataLayerForACountry(countryTitle: "Ireland")
    }
    
    func testConfirmedCasesDisplayedAgain() {
        givenIHaveAnInternetConnectionAndOpenTheApp()
        andIClickOnACountryWithATitle(countryTitle: "Ireland")
        andIChoseTypeOfCasesWithATitle(typeOfCases: "Recovered")
        andIChoseTypeOfCasesWithATitle(typeOfCases: "Confirmed")
        iSeeConfirmedCasesFromDataLayerForACountry(countryTitle: "Ireland")
    }
}
