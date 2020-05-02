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
        givenIHaveAnInternetConnectionAndOpenTheAp()
        iSeeAScreenWithAvailableCountries()
    }
}
